const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');

//initializations
const app = express();

//settings
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}));
app.set('view engine', '.hbs');
// Middlewares

//Middlewares - Funciones que se ejecutan cada que envian una peticion

app.use(morgan('dev'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
//Global Variables
app.use((req, res, next) => {
    
    next();
});

//Routes
app.use(require('./routes'));
app.use(require('./routes/authentication'));
app.use('/colaborador',require('./routes/colaborador'));
app.use('/inventario',require('./routes/inventario'));
app.use('/modelo', require('./routes/modelo'));
app.use('/marca', require('./routes/marca'));
//https://youtu.be/qJ5R9WTW0_E?t=1820

//Public
app.use(express.static(path.join(__dirname, 'public')));

//Starting the server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
});