# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webapp-config/webapp-config-1.0.ebuild,v 1.1 2004/03/03 00:55:56 stuart Exp $

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~stuart/webapp-config/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~x86"
IUSE=""
DEPEND=
RDEPEND="sys-apps/grep
	sys-apps/findutils
	sys-apps/sed
	sys-apps/gawk
	sys-apps/coreutils
	app-shells/bash"
S=${WORKDIR}/${P}

src_install () {
	dosbin sbin/webapp-config
	dodir /usr/lib/webapp-config
	cp -R lib/* ${D}/usr/lib/webapp-config/
	dodir /etc/conf.d
	cp config/webapp-config ${D}/etc/conf.d/

	dodoc examples/phpmyadmin-2.5.4-r1.ebuild
}
