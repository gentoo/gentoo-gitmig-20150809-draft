# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webapp-config/webapp-config-1.3.ebuild,v 1.2 2004/04/24 14:38:09 mholzer Exp $

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="x86 ~sparc ~ppc ~amd64 ~mips"
IUSE=""
DEPEND=
RDEPEND="sys-apps/grep
	sys-apps/findutils
	sys-apps/sed
	sys-apps/gawk
	sys-apps/coreutils
	app-shells/bash
	app-text/xmlto"
S=${WORKDIR}/${P}

src_compile () {
	# do nothing
	echo > /dev/null
}

src_install () {
	dosbin sbin/webapp-config
	dodir /usr/lib/webapp-config
	cp -R lib/* ${D}/usr/lib/webapp-config/
	dodir /etc/vhosts
	cp config/webapp-config ${D}/etc/vhosts/
	dodir /usr/share/webapps
	dodoc examples/phpmyadmin-2.5.4-r1.ebuild AUTHORS.txt README.txt TODO.txt CHANGES.txt examples/postinstall-en.txt
	doman doc/webapp-config.5 doc/webapp-config.8 doc/webapp.eclass.5
}
