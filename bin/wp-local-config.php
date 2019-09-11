<?php
/**
 * WordPress local config
 *
 * @package docker-wpcomvip
 */

// Conditionally turn on HTTPS since we're behind nginx-proxy.
if ( isset( $_SERVER['HTTP_X_FORWARDED_PROTO'] ) && 'https' === $_SERVER['HTTP_X_FORWARDED_PROTO'] ) { // Input var ok.
	$_SERVER['HTTPS'] = 'on';
}

// Indicate MACS environment.
define( 'MACS_ENV', 'local' );

// Disable automatic updates.
define( 'AUTOMATIC_UPDATER_DISABLED', true );

// This provides the host and port of the development Memcached server. The host
// should match the container name in . If you
// aren't using Memcached, it will simply be ignored.
$memcached_servers = array(
	array(
		'memcached',
		11211,
	),
);
