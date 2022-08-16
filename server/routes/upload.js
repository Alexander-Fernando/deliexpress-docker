const router = require('express').Router()
const cloudinary = require('cloudinary')
const auth = require('../middleware/auth')
const authAdmin = require('../middleware/authAdmin')
const fs = require('fs')


// subimos una imagen a cloudinary
cloudinary.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUD_API_KEY,
    api_secret: process.env.CLOUD_API_SECRET
})

// subiendo imagen solo para administrador
router.post('/upload', auth, authAdmin, (req, res) => {
    try {
        console.log(req.files.file)
        if(!req.files || Object.keys(req.files).length === 0)
            return res.status(400).send({msg: 'No se detectaron archivos'})

        const file = req.files.file;
        if((file.size) > 1024*1024){
            removeTmp(file.tempFilePath)
            return res.status(400).json({msg: "Archivo demasiado grande"})
        }

        if(file.mimetype !== 'image/jpeg' && file.mimetype !== 'image/png'){
            removeTmp(file.tempFilePath)
            return res.status(400).json({msg: "File format is incorrect."})
        }

        cloudinary.v2.uploader.upload(file.tempFilePath, {folder: 'deliexpress'},  async(err, result) => {
            if(err) throw err;
            
            removeTmp(file.tempFilePath)
            res.json({public_id: result.public_id, url: result.secure_url})
        })
    } catch (err) {
        res.status(500).json({msg: err.message})
    }
})

//Eliminando imagen
router.post('/destroy', auth, authAdmin, (req, res) => {
    try {
        const {public_id} = req.body
        if(!public_id) return res.status(500).json({msg: "No images Select"})
        
        cloudinary.v2.uploader.destroy(public_id, async(err, result) => {
            if(err) throw err;

            res.json({msg: "Deleted Image"})
        })
    } catch (err) {
        return res.status(500).json({msg: err.message})
    }
})

const removeTmp = (path) =>{
    fs.unlink(path, err=>{
        if(err) throw err;
    })
}

module.exports = router