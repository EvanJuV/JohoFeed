// Load mongoose package
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

// Connect to MongoDB and create/use database 
mongoose.connect('mongodb://localhost/johoFeedDB');

// Create schemas for all models in database
var UserSchema = new mongoose.Schema({
    username: {
        required: true,
        type: String,
        trim: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        match: /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i        
    },
    password: {
        required: true,
        type: String,
        trim: true
    },
    sources: [{
        type: Schema.Types.ObjectId,
        ref: 'Source'
    }],
    articles: {
        likes: [Schema.Types.Mixed],
        dislikes: [Schema.Types.Mixed],
        commented: [Schema.Types.Mixed]
    },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

var CategorySchema = new mongoose.Schema({
    title: {
        required: true,
        type: String,
        trim: true
    },
    feeds: [{
        type: Schema.Types.ObjectId,
        ref: 'Feed'
    }],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

var FeedSchema = new mongoose.Schema({
    title: {
        required: true,
        type: String,
        trim: true
    },
    id: {
        required: true,
        type: String,
        trim: true
    },
    website: {
        required: true,
        type: String,
        trim: true
    },
    language: {
        required: true,
        type: String,
        trim: true
    },
    active: {
        type: Boolean,
        default: true
    },
    articles: [{
        type: Schema.Types.ObjectId,
        ref: 'Article'
    }],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
});

var ArticleSchema = new mongoose.Schema({
    id: {
        required: true,
        type: String,
        index: true
    },
    title: {
        required: true,
        type: String,
        trim: true
    },
    link: {
        required: true,
        type: String,
        trim: true
    },
    image_url: {
        type: String,
        trim: true
    },
    description: {
        type: String,
        trim: true
    },
    author: {
        required: true,
        type: String,
        trim: true
    },
    publish_date: { 
        type: Date, 
        required: true 
    }, 
    likes: [{
        type: Schema.Types.ObjectId,
        ref: 'User'
    }],
    dislikes: [{
        type: Schema.Types.ObjectId,
        ref: 'User'
    }],
    comments: [{
        type: Schema.Types.ObjectId,
        ref: 'Comment'
    }],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
});

var CommentSchema = new mongoose.Schema({
    content: {
        required: true,
        type: String
    },
    author: {
        id: {
            type: Schema.Types.ObjectId,
            ref: 'User',
            required: true
        }
    },
    answers: [{
        type: Schema.Types.ObjectId,
        ref: 'Comment'
    }],
    likes: [{
        type: Schema.Types.ObjectId,
        ref: 'User'
    }],
    dislikes: [{
        type: Schema.Types.ObjectId,
        ref: 'User'
    }],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
});

// Create models based on the schema
var User = mongoose.model('User', UserSchema);
var Category = mongoose.model('Category', CategorySchema);
var Feed = mongoose.model('Feed', FeedSchema);
var Article = mongoose.model('Article', ArticleSchema);
var Comment = mongoose.model('Comment', CommentSchema);

var newUser = new User({username: "Paca", email: "e.juav24@gmail.com", password: "123"});

// newUser.save(function (err) {
//     if (err) {
//         console.log(err);
//     }
//     else console.log(newUser);
// });

newUser.articles.likes.push(new Article({
        id: "123456", 
        title: "Articulo Prueba", 
        link: "google.com",
        image_url: "blas",
        description: "un articulo",
        author: "Autor",
        publish_date: Date.now
    })
);

newUser.save();