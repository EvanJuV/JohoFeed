// Load mongoose package
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

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

module.exports = mongoose.model('Feed', FeedSchema);