# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webapp-config/webapp-config-1.10-r10.ebuild,v 1.8 2004/09/04 00:23:55 kugelfang Exp $

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~stuart/${PN}/${PN}-${PVR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha arm hppa amd64 ~ia64 ppc64"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/grep
	sys-apps/findutils
	sys-apps/sed
	sys-apps/gawk
	sys-apps/coreutils
	app-shells/bash
	app-portage/gentoolkit"

S=${WORKDIR}/${PF}

src_compile() {
	# do nothing
	true
}

src_install() {
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

pkg_postinst() {
	echo
	einfo "Now that you have upgraded webapp-config, you **must** update your"
	einfo "config files in /etc/vhosts/webapp-config before you emerge any"
	einfo "packages that use webapp-config."
	echo
	sleep 5
}
