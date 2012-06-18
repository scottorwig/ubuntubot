# this code requires at config file with the format specified in the README file
# specify the path here
config_file_path = r'ubuntubot.cfg'

import ConfigParser


def readconfig():
    config = ConfigParser.ConfigParser()
    config.read([config_file_path])    

    gmail_user = config.get('gmail', 'user')
    gmail_pwd = config.get('gmail', 'password')
    prowl_address = config.get('prowl', 'email')    
    follett_destination_directory = config.get('follett', 'destination_directory')
    powerschool_server_root = config.get('powerschool', 'server_root')
    powerschool_pw_page = config.get('powerschool', 'pw_page')
    powerschool_user_password = config.get('powerschool', 'username_password')
    browser_download_directory = config.get('powerschool', 'browser_download_directory')
    path_to_host_file = config.get('ps1000', 'path_to_host_file')
    log_path = config.get('logging','log_path')
    db_db = config.get('powerschoolmirror','database')
    db_user = config.get('powerschoolmirror','user')
    db_passwd = config.get('powerschoolmirror','password')
    

    config_values = {
        'gmail_user': gmail_user,
        'gmail_pwd': gmail_pwd,
        'prowl_address': prowl_address,
        'follett_destination_directory': follett_destination_directory,
        'powerschool_server_root': powerschool_server_root,
        'powerschool_pw_page': powerschool_pw_page,
        'powerschool_user_password': powerschool_user_password,
	'browser_download_directory': browser_download_directory,
        'path_to_host_file': path_to_host_file,
	'prowl_address': prowl_address,
	'log_path': log_path,
        'db_db': db_db,
        'db_user': db_user,
        'db_passwd': db_passwd,
    }

    return config_values
