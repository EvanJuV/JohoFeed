// Load mongoose package
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

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


module.exports = mongoose.model('Category', CategorySchema);