# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.84.0.ebuild,v 1.1 2002/03/01 06:51:13 verwilst Exp $

S="${WORKDIR}/GnomeMeeting-${PV}"
SRC_URI="http://www.gnomemeeting.org/clicks_counter.php?http://www.gnomemeeting.org/downloads/latest/sources/GnomeMeeting-${PV}.tar.gz"
HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"

DEPEND="virtual/glibc
	>=gnome-base/gnome-libs-1.4.1.4
	>=dev-libs/pwlib-1.2.12
	>=net-libs/openh323-1.8.0
	>=media-libs/gdk-pixbuf-0.16.0
	>=dev-libs/openssl-0.9.6c
	>=gnome-base/gconf-1.0.8"
