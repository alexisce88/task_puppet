# @summary Define a mailhost
#
# @param ensure
#   Enables or disables the specified mailhost
# @param listen_ip
#   Default IP Address for NGINX to listen with this server on. Defaults to all interfaces (*)
# @param listen_port
#   Default IP Port for NGINX to listen with this server on.
# @param listen_options
#   Extra options for listen directive like 'default' to catchall.
# @param ipv6_enable
#   value to enable/disable IPv6 support (false|true). Module will check to see
#   if IPv6 support exists on your system before enabling.
# @param ipv6_listen_ip
#   Default IPv6 Address for NGINX to listen with this server on. Defaults to
#   all interfaces (::)
# @param ipv6_listen_port
#   Default IPv6 Port for NGINX to listen with this server on.
# @param ipv6_listen_options
#   Extra options for listen directive like 'default' to catchall.
# @param ssl
#   Indicates whether to setup SSL bindings for this mailhost.
# @param ssl_cert
#   Pre-generated SSL Certificate file to reference for SSL Support. This is
#   not generated by this module.
# @param ssl_ciphers
#   Override default SSL ciphers.
# @param ssl_client_cert
#   Pre-generated SSL Certificate file to reference for client verify SSL
#   Support. This is not generated by this module.
# @param ssl_crl
#   String: Specifies CRL path in file system
# @param ssl_dhparam
#   This directive specifies a file containing Diffie-Hellman key agreement
#   protocol cryptographic parameters, in PEM format, utilized for exchanging
#   session keys between server and client.
# @param ssl_ecdh_curve
#   This directive specifies a curve for ECDHE ciphers.
# @param ssl_key
#   Pre-generated SSL Key file to reference for SSL Support. This is not
#   generated by this module.
# @param ssl_password_file
#   This directive specifies a file containing passphrases for secret keys.
# @param ssl_port
#   Default IP Port for NGINX to listen with this SSL server on.
# @param ssl_prefer_server_ciphers
#   Specifies that server ciphers should be preferred over client ciphers when
#   using the SSLv3 and TLS protocols.
# @param ssl_protocols
#   SSL protocols enabled.
# @param ssl_session_cache
#   Sets the type and size of the session cache.
# @param ssl_session_ticket_key
#   This directive specifies a file containing secret key used to encrypt and
#   decrypt TLS session tickets.
# @param ssl_session_tickets
#   Whether to enable or disable session resumption through TLS session tickets.
# @param ssl_session_timeout
#   Specifies a time during which a client may reuse the session parameters
#   stored in a cache.
# @param ssl_trusted_cert
#   Specifies a file with trusted CA certificates in the PEM format used to
#   verify client certificates and OCSP responses if ssl_stapling is enabled.
# @param ssl_verify_depth
#   Sets the verification depth in the client certificates chain.
# @param starttls
#   Enable STARTTLS support
# @param protocol
#   Mail protocol to use
# @param auth_http
#   With this directive you can set the URL to the external HTTP-like server
#   for authorization.
# @param xclient
#   Whether to use xclient for smtp
# @param proxy_protocol 
#   Wheter to use proxy_protocol
# @param proxy_smtp_auth     
#   Wheter to use proxy_smtp_auth
# @param imap_auth
#   Sets permitted methods of authentication for IMAP clients.
# @param imap_capabilities
#   Sets the IMAP protocol extensions list that is passed to the client in
#   response to the CAPA command.
# @param imap_client_buffer
#   Sets the IMAP commands read buffer size.
# @param pop3_auth
#   Sets permitted methods of authentication for POP3 clients.
# @param pop3_capabilities
#   Sets the POP3 protocol extensions list that is passed to the client in
#   response to the CAPA command.
# @param smtp_auth
#   Sets permitted methods of SASL authentication for SMTP clients.
# @param smtp_capabilities
#   Sets the SMTP protocol extensions list that is passed to the client in
#   response to the EHLO command.
# @param proxy_pass_error_message
#   Indicates whether to pass the error message obtained during the
#   authentication on the backend to the client.
# @param server_name
#   List of mailhostnames for which this mailhost will respond.
# @param raw_prepend
#   A single string, or an array of strings to prepend to the server directive
#   (after mailhost_cfg_prepend directive). NOTE: YOU are responsible for a
#   semicolon on each line that requires one.
# @param raw_append
#   A single string, or an array of strings to append to the server directive
#   (after mailhost_cfg_append directive). NOTE: YOU are responsible for a
#   semicolon on each line that requires one.
# @param mailhost_cfg_append
#   It expects a hash with custom directives to put after everything else
#   inside server
# @param mailhost_cfg_prepend
#   It expects a hash with custom directives to put before everything else
#   inside server
#
# @example SMTP server definition
#   nginx::resource::mailhost { 'domain1.example':
#     ensure          => present,
#     auth_http       => 'server2.example/cgi-bin/auth',
#     protocol        => 'smtp',
#     listen_port     => 587,
#     ssl_port        => 465,
#     starttls        => 'only',
#     xclient         => 'off',
#     proxy_protocol  => 'off',
#     proxy_smtp_auth => 'off',
#     ssl             => true,
#     ssl_cert        => '/tmp/server.crt',
#     ssl_key         => '/tmp/server.pem',
#   }
#
define nginx::resource::mailhost (
  Stdlib::Port $listen_port,
  Enum['absent', 'present'] $ensure              = 'present',
  Variant[Array[String], String] $listen_ip      = '*',
  Optional[String] $listen_options               = undef,
  Boolean $ipv6_enable                           = false,
  Variant[Array[String], String] $ipv6_listen_ip = '::',
  Stdlib::Port $ipv6_listen_port                 = $listen_port,
  String $ipv6_listen_options                    = 'default ipv6only=on',
  Boolean $ssl                                   = false,
  Optional[String] $ssl_cert                     = undef,
  String $ssl_ciphers                            = $nginx::ssl_ciphers,
  Optional[String] $ssl_client_cert              = undef,
  Optional[String] $ssl_crl                      = undef,
  Optional[String] $ssl_dhparam                  = $nginx::ssl_dhparam,
  Optional[String] $ssl_ecdh_curve               = undef,
  Optional[String] $ssl_key                      = undef,
  Optional[String] $ssl_password_file            = undef,
  Optional[Stdlib::Port] $ssl_port               = undef,
  Enum['on', 'off'] $ssl_prefer_server_ciphers   = $nginx::ssl_prefer_server_ciphers,
  String $ssl_protocols                          = $nginx::ssl_protocols,
  Optional[String] $ssl_session_cache            = undef,
  Optional[String] $ssl_session_ticket_key       = undef,
  Optional[String] $ssl_session_tickets          = undef,
  String $ssl_session_timeout                    = '5m',
  Optional[String] $ssl_trusted_cert             = undef,
  Optional[Integer] $ssl_verify_depth            = undef,
  Enum['on', 'off', 'only'] $starttls            = 'off',
  Optional[Enum['imap', 'pop3', 'sieve', 'smtp']] $protocol = undef,
  Optional[String] $auth_http                    = undef,
  Optional[String] $auth_http_header             = undef,
  Enum['on', 'off'] $xclient                     = 'on',
  Enum['on', 'off'] $proxy_protocol              = 'off',
  Enum['on', 'off'] $proxy_smtp_auth             = 'off',
  Optional[String] $imap_auth                    = undef,
  Optional[Array] $imap_capabilities             = undef,
  Optional[String] $imap_client_buffer           = undef,
  Optional[String] $pop3_auth                    = undef,
  Optional[Array] $pop3_capabilities             = undef,
  Optional[String] $smtp_auth                    = undef,
  Optional[Array] $smtp_capabilities             = undef,
  Optional[Variant[Array, String]] $raw_prepend  = undef,
  Optional[Variant[Array, String]] $raw_append   = undef,
  Optional[Hash] $mailhost_cfg_prepend           = undef,
  Optional[Hash] $mailhost_cfg_append            = undef,
  String $proxy_pass_error_message               = 'off',
  Array $server_name                             = [$name]
) {
  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  # Add IPv6 Logic Check - Nginx service will not start if ipv6 is enabled
  # and support does not exist for it in the kernel.
  if ($ipv6_enable and !$facts['networking']['ip6']) {
    warning('nginx: IPv6 support is not enabled or configured properly')
  }

  # Check to see if SSL Certificates are properly defined.
  if ($ssl or $starttls == 'on' or $starttls == 'only') {
    if ($ssl_cert == undef) or ($ssl_key == undef) {
      fail('nginx: SSL certificate/key (ssl_cert/ssl_cert) and/or SSL Private must be defined and exist on the target system(s)')
    }
  }

  $config_dir  = "${nginx::conf_dir}/conf.mail.d"
  $config_file = "${config_dir}/${name}.conf"

  concat { $config_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => $nginx::root_group,
    mode    => $nginx::global_mode,
    notify  => Class['nginx::service'],
    require => File[$config_dir],
    tag     => 'nginx_config_file',
  }

  if $ssl_port == undef or $listen_port != $ssl_port {
    concat::fragment { "${name}-header":
      target  => $config_file,
      content => template('nginx/mailhost/mailhost.erb'),
      order   => '001',
    }
  }

  # Create SSL File Stubs if SSL is enabled
  if $ssl {
    concat::fragment { "${name}-ssl":
      target  => $config_file,
      content => template('nginx/mailhost/mailhost_ssl.erb'),
      order   => '700',
    }
  }
}
