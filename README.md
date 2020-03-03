### Test Técnico Backend Developer PJ

**Se pide crear una API en Rails 5, cumpliendo los siguientes requerimientos:**
1. Se debe hacer el CRUD para Tiendas (Store), con los siguientes atributos.
a. name: String
b. address: Text
c. email: String (Default: francisco.abalan@pjchile.com)
d. phone: String
2. Se debe hacer el CRUD para Productos (Product), los que pueden estar en muchas
tiendas y cada tienda puede tener muchos productos.
a. name: String
b. sku: String
c. type: String (opc: “Pizza”, “Complement”)
d. price: Integer
3. Se debe hacer el CRUD para Órdenes (Order), la que puede llevar varios productos
y le pertenece a una tienda. Se espera que éste sea el endpoint principal, donde se
pueda crear una orden con una serie de productos e indicando una tienda. El total
debe ser calculado como la suma de los productos agregados (Σ price).
a. total: Integer
4. Se deben crear los test (Rspec) de modelo y controlador para todas las clases y
definiciones.
5. Se debe levantar la aplicación en algún servidor para poder probar los endpoints
desde postman.
6. Se debe usar como base de datos Postgresql.

**Puntos Extras:**
1. Configuración de Rubocop para el análisis estático del código.
2. Implementación de un servicio de mailing, que envíe un mail a la tienda cada vez que se
haga una orden indicando: Nombre tienda, hora del pedido, nombre de los productos del
pedido y el total de este.
3. Construcción de documentación de la API, mediante Swagger.
4. Trabajar cada requerimiento como una feature branch, creando un Pull Request para
cada actualización.
5. Levantar la aplicación en una instancia EC2 de AWS.