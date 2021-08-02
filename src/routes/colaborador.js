const express = require('express');
const router = express.Router();
const request = require('request');
const HOST = 'https://herojsapi.herokuapp.com/';
const fetch = require('node-fetch');

/**
 * Este js de colaborador ,todos sus gets son asincronos por lo cual se utilizo
 * la libreria request para poder manejar multiples peticiones. 
 */


/**
 * Esta es la ruta principal para mostrar los colaboradores
 * 
 */
 router.get('/', async (req, res) => {

    /** */
    const resColaborador = await fetch(HOST + 'colaboradorcontroller.php');
    console.log(resColaborador);
    const colaboradores = await resColaborador.json();

    const resSede = await fetch(HOST + 'sedecontroller.php');
    const sedes = await resSede.json();

    const resEquipo = await fetch(HOST + 'equipocontroller.php');
    const equipos = await resEquipo.json();

    const resPuesto = await fetch(HOST + 'puestocontroller.php');
    const puestos = await resPuesto.json();
    
    res.render('colaborador/index', { colaboradores, sedes, equipos, puestos });
});



/** 
 * Desplegar los datos de un colaborador
 * 
 */


router.get('/perfil/:id', async (req, res) => {

    const { id } = req.params;
    const resColaborador = await fetch(HOST + 'colaboradorcontroller.php?id=' + id);
    const colaborador = await resColaborador.json();
    const resUsuarios = await fetch(HOST + 'tipousuariocontroller.php');
    const usuarios = await resUsuarios.json();
    res.render('colaborador/perfil', { colaborador, usuarios });

});



router.get('/editar/:id', async (req, res) => {

    const { id } = req.params;
    const resColaborador = await fetch(HOST + 'colaboradorcontroller.php?id=' + id);
    const colaborador = await resColaborador.json();

    const resSede = await fetch(HOST + 'sedecontroller.php');
    const sedes = await resSede.json();

    const resEquipo = await fetch(HOST + 'equipocontroller.php');
    const equipos = await resEquipo.json();

    const resPuesto = await fetch(HOST + 'puestocontroller.php');
    const puestos = await resPuesto.json();

    const resArea = await fetch(HOST + 'areacontroller.php');
    const areas = await resArea.json();

    const resUsuario = await fetch(HOST + 'tipousuariocontroller.php');
    const usuarios = await resUsuario.json();
    console.log(colaborador)
    res.render('colaborador/editar', { colaborador, sedes, equipos, puestos, areas , usuarios});
});

router.post('/editar/guardarusuario/:id', (req, res) => {
    const { isd } = req.params;
    const usuario = {
        'nombreusuario': req.body.nombreusuario,
        'password': req.body.password,
        'colaborador': req.body.colaborador,
        'tipo':req.body.tipo
    }
    console.log(usuario)
    request.post(HOST + '/usuariocontroller.php', { form: usuario, json: true }, (err, r) => {
        if (err) {
            console.log(err);
        } else {
            res.redirect('/colaborador/editar/:id');
        }
    })
});

router.get('/equipo', async (req, res) => {

    const resEquipo = await fetch(HOST + 'equipocontroller.php');

    const equipos = await resEquipo.json();

    console.log(equipos);
    res.render('colaborador/equipo', { equipos });
});

router.get('/sede', async (req, res) => {

    const resSede = await fetch(HOST + 'sedecontroller.php');


    const sedes = await resSede.json();

    console.log(sedes);
    res.render('colaborador/sede', { sedes});
});


router.post('/guardarcolaborador', (req, res) => {
    let colaborador = {
        "nombre": req.body.nombre,
        "paterno": req.body.paterno,
        "materno": req.body.materno,
        "numservidor": req.body.numservidor,
        "fecha": req.body.fecha,
        "email": req.body.email,
        "comodato": req.body.comodato,
        "sede": req.body.sede,
        "equipo": req.body.equipo,
        "puesto": req.body.puesto,
        "celular": req.body.celular,
        "shortel": req.body.shortel
    };
    console.log(colaborador);
    request.post(HOST + '/colaboradorcontroller.php', { form: colaborador, json: true }, (err, r) => {
        if (err) {
            console.log(err);
        } else {
            res.redirect('/colaborador/');
        }
    })

});

router.put('/actualizarcolaborador', (req, res) => {
    let colaborador = {
        "nombre": req.body.nombre,
        "paterno": req.body.paterno,
        "materno": req.body.materno,
        "numservidor": req.body.numservidor,
        "fecha": req.body.fecha,
        "email": req.body.email,
        "comodato": req.body.comodato,
        "sede": req.body.sede,
        "equipo": req.body.equipo,
        "puesto": req.body.puesto
    };

    console.log(colaborador);

    request.put(HOST + '/colaboradorcontroller.php', { form: colaborador, json: true }, (err, r) => {
        if (err) {
            console.log(err);
        } else {
            res.redirect('/colaborador/');
        }
    })

});

router.post('/sede/guardarsede', (req, res) => {
    const sede = {
        'codsede': req.body.codigosede,
        'nombre': req.body.nombresede,
        'calle': req.body.calle,
        'numext':req.body.numext,
        'numint':req.body.numint,
        'colonia':req.body.colonia,
        'postal':req.body.postal,
        'ciudad':req.body.ciudad,
        'estado':req.body.estado,
        'pais':req.body.pais,
        'telefono':req.body.telefono
    }
    console.log(sede)
    request.post(HOST + 'sedecontroller.php', { form: sede, json: true }, (err, r) => {
        if (err) {
            console.log(err);
        } else {
            res.redirect('/colaborador/sede/');
        }
    })
});

module.exports = router;