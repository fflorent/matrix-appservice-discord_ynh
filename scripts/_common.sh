#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="postgresql"
# Node version
NODEJS_VERSION=14

#=================================================
# PERSONAL HELPERS
#=================================================
install_node_deps() {
    pushd "$final_path"
        ynh_use_nodejs
        ynh_exec_warn_less sudo -u $app env $ynh_node_load_PATH NODE_ENV=production npm install
        ynh_exec_warn_less sudo -u $app env $ynh_node_load_PATH NODE_ENV=production npm run build
    popd
}

run_discordas() {
    ynh_exec_warn_less sudo -u $app env $ynh_node_load_PATH NODE_ENV=production node build/src/discordas.js -r -u "http://localhost:$port" -c config.yaml
}

setup_final_path_rights() {
    chmod 750 "$final_path"
    chmod -R o-rwx "$final_path"
    chown -R $app:$app "$final_path"
}
