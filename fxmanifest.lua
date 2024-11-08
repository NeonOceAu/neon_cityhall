fx_version 'cerulean'
game 'gta5'

description 'City Hall'
author 'Neon Scripts'
version '1.0.0'

lua54 'yes'

shared_scripts {
    'config.lua',
    'strings.lua'
}

client_scripts {
    '@ox_lib/init.lua',
    'client/*'
}

server_scripts {
    'server/*'
}

dependencies {
    'ox_lib'
}