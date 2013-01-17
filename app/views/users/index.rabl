collection :@users
attributes :id, :name, :email
child(:user) { attributes :id }
node(:read) { |user| user.read_by?(@users) }