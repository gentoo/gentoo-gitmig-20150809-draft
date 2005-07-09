# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webapp-config/webapp-config-1.9-r2.ebuild,v 1.8 2005/07/09 13:47:07 swegener Exp $

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tar.bz2"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="x86 ~sparc ~ppc amd64 ~mips alpha ~hppa ia64"
IUSE=""
DEPEND=
RDEPEND="sys-apps/grep
	sys-apps/findutils
	sys-apps/sed
	sys-apps/gawk
	sys-apps/coreutils
	app-shells/bash
	app-portage/gentoolkit"
S=${WORKDIR}/${PF}

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
	dohtml doc/webapp-config.5.html doc/webapp-config.8.html doc/webapp.eclass.5.html
}
