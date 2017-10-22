from django.shortcuts import redirect
from django.views import generic
from django.contrib.auth import authenticate,login,logout
from django.views.generic import View
from django.views.decorators.csrf import csrf_exempt
from .models import Tour,Profile
from django.shortcuts import render
import logging
from django.db import transaction
from .forms import UserForm


logger = logging.getLogger("django")

'''
	create page for ordering tour
	calculate final price with discount
	send request to buy a tour if number of places was chosen
'''

@csrf_exempt
def buy(request,tour_id):
    if request.method=="GET":
        if not request.user.is_authenticated():
            return redirect('agency:user_login')

        else:
            tour = Tour.objects.get(pk=tour_id)
            return render(request, 'agency/buyPage.html', {
                'tour': tour,
                'user': Profile.objects.get(user_id=request.user.id),
                'price': tour.price *(1 - Profile.objects.get(user_id=request.user.id).discount/100),
            })
    else: return buyTour(request, tour_id, request.POST['places'])

'''
	buy chosen tour with chosen number of places
	if user is not authenticated send him  to login page
'''
@transaction.atomic
@csrf_exempt
def buyTour(request,tour_id,places):
        if not request.user.is_authenticated():
            return redirect('agency/login.html')
        else:
            logger.info("buy "+ str(places)+"tour id :" +str(tour_id))
            tour = Tour.objects.get(pk=tour_id)
            user = Profile.objects.get(user_id=request.user.id)
            try:
                with transaction.atomic():
                    tour.places -= int(places)
                    user.totalSum += int(places) * tour.price
                    tour.save()
                    user.save()
                    logger.info("operation: success")
                    return render(request, 'agency/operation.html', {'success': True})
            except :
                logger.info("operation: failed")
                return render(request, 'agency/operation.html', {'success':False})

'''
	log in (if he currently log out) or log out (if logged in) the current client
'''
def loginout(request):
    if not request.user.is_authenticated():
        return redirect('agency:user_login')
    else:
         logout(request)
         return render(request,'agency/mainPage.html')

'''
	list view for showing all tours in the agency
'''			 
		 
class IndexView(generic.ListView):
    template_name = "agency/index.html"
    context_object_name = 'all_tours'
    def get_queryset(self):
        logger.info("show tours")
        return Tour.objects.all()

		
'''
	show the detail information about chosen tour 
'''			
class DetailView(generic.DetailView):
    model = Tour
    logger.info("show tour")
    template_name = "agency/detail.html"


'''
	show the main page of the site
'''		
	
def mainPage(request):
    logger.info("show main page")
    return render(request,'agency/mainPage.html')

	
'''
	log in user if all data is correct,
	or explain why the data is not ok
'''	
	
@csrf_exempt
def user_login(request):
    if request.method == "POST":
        logger.info("work with new user")
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                all_tours = Tour.objects.all()
                return render(request, 'agency/index.html', {'all_tours': all_tours})
            else:
                return render(request, 'agency/login.html', {'error_message': 'Your account has been disabled'})
        else:
            return render(request, 'agency/login.html', {'error_message': 'Invalid login'})
    return render(request, 'agency/login.html')


	
'''
	view for work with user
'''	
class UserFormView(View):
    form_class = UserForm
    template_name = "agency/registration_form.html"

	'''
		return blanked form when user asks 
		for registry
	'''	
	
    @csrf_exempt
    def get(self,request):
        form = self.form_class(None)
        return render(request,self.template_name,{'form':form})

		
	'''
		registry new user if the input data was correct
		and shows the error message if some error has occurred 
	'''		
		
    @csrf_exempt
    def post(self,request):
        form = self.form_class(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            ''' 
				normalize  data from the form
			'''
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user.set_password(password)
            user.save()
            profile = Profile(user_id=user.pk)
            profile.discount=0
            profile.save()
            user = authenticate(username=username,password=password)
            if user is not None:
                if user.is_active:
                    login(request,user)
                    return redirect("agency:index")

					
        logger.info("some bad data have been sent")
        return render(request, self.template_name, {'form': form}, {'error_message': 'Invalid data'})






