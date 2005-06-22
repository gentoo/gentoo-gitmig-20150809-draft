# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/files/kismet-2005.06.1-conf.d,v 1.1 2005/06/22 21:36:34 brix Exp $

# Kismet configuration is done in /etc/kismet.conf

# To use the kismet init script, you must have "logtemplate" set to a location
# that is writable by the user assigned by "suiduser".
# e.g.
# suiduser=foo
# logtemplate=%h/kismet_log/%n-%d-%i.%l

# Options to pass to kismet_server, see `kismet_server --help`
KISMET_SERVER_OPTIONS=""
