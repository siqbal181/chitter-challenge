require_relative './user'

class UserRepository
  def all
    sql = 'SELECT email_address, username, password FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |row|
      user = User.new
      user.id = row['id']
      user.email_address = row['email_address']
      user.username = row['username']
      user.password = row['password']
      users << user
    end
    return users
  end

  def create(new_user)
    # encrypted_password = BCrypt::Password.create(new_user.password)

    # sql = 'INSERT INTO users (email_address, username, password)
    #     VALUES($1, $2, $3);'
    # sql_params = [
    #   new_user.email_address,
    #   new_user.user_name
    #   encrypted_password
    # ]

    # result_set = DatabaseConnection.exec_params(sql, sql_params)

    # new_user = User.new
    # new_user.email_address = email_address
    # new_user.user_name = user_name
    # new_user.password = password

    # return new_user
  end
  
  def find_by_email(email)
  end

end
