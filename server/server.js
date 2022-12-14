require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const fileUpload = require('express-fileupload');
const cookieParser = require('cookie-parser');
// Archivvo config.js
// const {URL_CONNECTION_MONGO} = require('./config.js');
// Avisar la existencia del cliente
const router = express.Router();

const app = express();
app.use(express.json());
app.use(cookieParser());
app.use(cors())
app.use(fileUpload({
    useTempFiles: true
}))

// Routes
router.use(function(req,res){
    res.sendFile(path.join(__dirname, '../client', 'build', 'index.html'));
})
app.use('/user', require('./routes/userRouter'))
app.use('/api', require('./routes/categoryRouter'))
app.use('/api', require('./routes/upload'))
app.use('/api', require('./routes/productRouter'))
app.use('/api', require('./routes/paymentRouter'))

// Conectando a mongodb
const URI = process.env.MONGODB_URL
mongoose.connect(URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true

}, err => {
    if (err) throw err;
    console.log('Connected to MongoDB!!!');
});

app.get('/', (req, res) => {
    res.json({msg: "RAAAAAAAAAAAAAAA SERVER"})
})

const PORT = process.env.PORT || 5000
app.listen(PORT, () => { console.log('Server is runing on pot', PORT) })

/* const URI = process.env.MONGODB_URL

mongoose
    .connect(URI)
    .then(() => console.log("DBConection Successfull!"))
    .catch((err) => { console.log(err) });

app.use(express.json())
app.use('/user', require('./routes/userRouter'))

app.listen(process.env.PORT || 5000, () => {
    console.log("Backend server is runing")
}) */