class OrdersController < ApplicationController

  def create
    @flight = Flight.find(params[:flight_id])
    mess = "everuthing is ok"
    Flight.transaction do
      Order.transaction do
        if params[:order][:category] == "1"
        then  if @flight.placesBus <= 0 then

                mess ="some error has occured"
                raise ActiveRecord::Rollback

              end
        else  if @flight.placesStan <= 0 then
                mess ="some error has occured"
                raise ActiveRecord::Rollback
              end
        end
      order = @flight.orders.create(order_params)
      if order
        if params[:order][:category] == "1"
          then  if @flight.placesBus > 0 then @flight.placesBus -=1
                else
                  mess ="some error has occured"
                  raise ActiveRecord::Rollback

                end
        else  if @flight.placesStan > 0 then @flight.placesStan -=1

              else
                mess ="some error has occured"
                raise ActiveRecord::Rollback

              end
        end
        @flight.save
      else
        mess ="some error has occured"
      end

      end
    end
    redirect_to flight_path(@flight), :notice =>mess
    return
  end

  private
  def order_params
    params.require(:order).permit(:hasPriv, :name,:surname, :passport ,:hasLag, :category)

  end

end
