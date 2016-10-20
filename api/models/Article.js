// Load mongoose package
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

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

module.exports = mongoose.model('Article', ArticleSchema);