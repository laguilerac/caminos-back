# Organizations
wingu = Organization.create(name: "Wingu", description: "Tecnología sin fines de lucro")
acij = Organization.create(name: "ACIJ", description: "La Asociación Civil por la Igualdad y la Justicia (ACIJ) es una organización apartidaria, sin fines de lucro dedicada a la defensa de los derechos de los grupos más desfavorecidos de la sociedad y el fortalecimiento de la democracia en Argentina.")
# Users
USERS = [
  { username: 'cavi', email: 'agustin@winguweb.org', password: 'nadanada', first_name: 'Agustin', active: true, approved: true, confirmed: true, roles: [:admin] },
  { username: 'facu', email: 'facundo@winguweb.org', password: 'nadanada', first_name: 'Facundo', active: true, approved: true, confirmed: true, roles: [:ambassador], entity: wingu },
  { username: 'carlos', email: 'carlos@winguweb.org', password: 'nadanada', first_name: 'Carlos', active: true, approved: true, confirmed: true, roles: [:admin, :ambassador], entity: wingu },
  { username: 'cou', email: 'constanza@winguweb.org', password: 'nadanada', first_name: 'Constanza', active: true, approved: true, confirmed: true, roles: [:admin], entity: acij },
]
User.where(username: USERS.map{ |data| data[:username] }).destroy_all
USERS.each do |data|
  data.merge!(profile: Profile.new(first_name: data.delete(:first_name)))
  user = User.new(data)
  user.save!
end
