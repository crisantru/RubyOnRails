#class NewUserEmail < ActionMailer::Base
#  def notify_user(user)
#    @user = user
#    mail(to: 'cotizacionesEtidoma@gmail.com', from: @user.email, subject: 'Cotizacion para Etidoma')
    #mail(to: 'templario_or@hotmail.com', from: @user.email, subject: 'Cotizacion para Etidoma')
#  end
#end


class NewUserEmail < ActionMailer::Base
  #default :from => 'any_from_address@example.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def notify_user(user)
    @user = user
    mail( :to => 'crisantru@gmail.com', from: @user.email, :subject => 'Thanks for signing up for our amazing app' )
  end
end
