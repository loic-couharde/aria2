const webpack = require("webpack");
const baseConfig = require('./webpack.config.base.js');

module.exports = {...baseConfig, plugins: [].concat(baseConfig.plugins, new webpack.EnvironmentPlugin(['SECRET']))};
