# Enable service during startup and start service
default['vsftpd']['enabled'] = true

# Configuration directory of vsftpd
default['vsftpd']['etcdir'] = '/etc/vsftpd'

# This is different on some distributions
default['vsftpd']['configfile'] = value_for_platform_family(
  'rhel'   => '/etc/vsftpd/vsftpd.conf',
  'debian' => '/etc/vsftpd.conf',
  'default' => '/etc/vsftpd.conf'
)

# Only allow access to certain users
# Default: no users are allowed to access FTP
default['vsftpd']['allowed'] = [ ]

# Depending on configuration of vsftpd allow users to run
# non-chroot or defines users that have to be chroot'ed
# Default: chroot all users but those defined here
default['vsftpd']['chroot'] = [ ]


# Various configuration options with some sane defaults
# For details on these please check the official documentation
default['vsftpd']['config'] = {
  'session_support'             => 'YES',
  'force_dot_files'             => 'NO',
  'hide_ids'                    => 'YES',
  'download_enable'             => 'YES',
  'anonymous_enable'            => 'NO',
  'anon_root'                   => '',
  'anon_world_readable_only'    => 'NO',
  'anon_upload_enable'          => 'NO',
  'anon_mkdir_write_enable'     => 'NO',
  'no_anon_password'            => 'NO',
  'ftp_username'                => 'ftp',
  'local_enable'                => 'YES',
  'local_root'                  => '',
  'user_config_dir'             => node['vsftpd']['etcdir'] + '/users.d',
  'guest_enable'                => 'NO',
  'guest_username'              => 'ftp',
  'write_enable'                => 'YES',
  'local_umask'                 => '022',
  'dirmessage_enable'           => 'YES',
  'message_file'                => '.message',
  'xferlog_enable'              => 'YES',
  'xferlog_file'                => '/var/log/xferlog',
  'xferlog_std_format'          => 'YES',
  'connect_from_port_20'        => 'YES',
  'chmod_enable'                => 'YES',
  'chown_uploads'               => 'NO',
  'chown_username'              => 'nobody',
  'idle_session_timeout'        => '600',
  'data_connection_timeout'     => '120',
  'nopriv_user'                 => 'nobody',
  'async_abor_enable'           => 'NO',
  'ascii_upload_enable'         => 'NO',
  'ascii_download_enable'       => 'NO',
  'ftpd_banner'                 => 'FTP Service managed by Chef',
  'banner_file'                 => '',
  'cmds_allowed'                => '',
  'deny_email_enable'           => 'NO',
  'banned_email_file'           => node['vsftpd']['etcdir'] + '/banned_emails',
  'userlist_enable'             => 'YES',
  'userlist_deny'               => 'NO',
  'userlist_file'               => node['vsftpd']['etcdir'] + '/vsftpd.user_list',
  'chroot_local_user'           => 'YES',
  'chroot_list_enable'          => 'YES',
  'chroot_list_file'            => node['vsftpd']['etcdir'] + '/vsftpd.chroot_list',
  'ls_recurse_enable'           => 'NO',
  'listen'                      => 'YES',
  'listen_address'              => node['ipaddress'],
  'listen_ipv6'                 => 'NO',
  'listen_address6'             => '',
  'pasv_enable'                 => 'YES',
  'pasv_address'                => node['ipaddress'],
  'pasv_max_port'               => '5590',
  'pasv_min_port'               => '5555',
  'port_enable'                 => 'YES',
  'pam_service_name'            => 'vsftpd',
  'tcp_wrappers'                => 'YES',
  'anon_max_rate'               => '0',
  'local_max_rate'              => '0',
  'max_clients'                 => '0',
  'max_per_ip'                  => '0',
	'ssl_enable'                  => 'YES',
	'allow_anon_ssl'              => 'NO',
	'force_local_data_ssl'        => 'NO',
	'force_local_logins_ssl'      => 'NO',
	'ssl_tlsv1'                   => 'YES',
	'ssl_sslv2'                   => 'NO',
	'ssl_sslv3'                   => 'NO',
	'rsa_cert_file'               => node['vsftpd']['etcdir'] + '/vsftpd.pem',
	'rsa_private_key_file'        => node['vsftpd']['etcdir'] + '/vsftpd.key'
}

# If ssl_enable == 'YES', set these parameters for the certificate to be created. Refer to the openssl cookbook's openssl_x509 LWRP and the _ssl.rb recipe for more options.
default['vsftpd']['ssl']['common_name'] = 'www.example.com'
default['vsftpd']['ssl']['org']         = 'Example Company'
default['vsftpd']['ssl']['org_unit']    = 'Research and Development'
default['vsftpd']['ssl']['country']     = 'US'


# Addresses a compatibility breaking upgrade, might be better to set to NO explicitly but for testing purposes it's enabled
if (node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 14.04) || (node['platform'] == 'centos' && node['platform_version'].to_f >= 7.0)
  default['vsftpd']['config']['allow_writeable_chroot'] = 'YES'
end
