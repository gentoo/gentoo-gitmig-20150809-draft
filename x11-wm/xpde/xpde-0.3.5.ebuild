# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xpde/xpde-0.3.5.ebuild,v 1.2 2004/03/28 04:47:05 mr_bones_ Exp $

DESCRIPTION="A Desktop Environment modelled after the O/S from Redmond, WA"
HOMEPAGE="http://www.xpde.com/"
SRC_URI="http://www.xpde.com/releases/${P}-20030426.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	einfo
	einfo "This is a binary-only package (sadly)"
	einfo "No files to compile."
	einfo
}

src_install() {
	# The install is the ${S}/install.sh, Gentoo-ified
	# As releases change often, don't just version
	# bump and expect things to work right.  Check for changes.
	cd ${S}

	dodir /opt/xpde/bin/apps
	dodir /opt/xpde/bin/applets

	dodir /opt/xpde/share/apps
	dodir /opt/xpde/share/applets
	dodir /opt/xpde/share/doc
	dodir /opt/xpde/share/fonts
	dodir /opt/xpde/share/icons

	exeinto /opt/xpde/bin
	doexe *.so* XPde XPwm stub.sh
	doexe ${FILESDIR}/install-config.sh

	exeinto /opt/xpde/bin/applets
	doexe DateTimeProps appexec networkstatus networkproperties \
		xpsu mouse keyboard regional desk

	exeinto /opt/xpde/bin/apps
	doexe taskmanager notepad calculator fileexplorer

	dodir /opt/xpde/themes
	cp -a themes/default ${D}/opt/xpde/themes

	cp -a defaultdesktop ${D}/opt/xpde/share
	cp xinitrcDEFAULT ${D}/opt/xpde/share

	dodoc AUTHORS COPYING ChangeLog INSTALL gpl.txt
	dohtml -A txt,xml -r doc/*
}

pkg_postinst() {
	einfo
	einfo "sh /opt/xpde/bin/install-config.sh"
	einfo
	einfo "This will install a default configuration into your"
	einfo "home directory"
	einfo
}
