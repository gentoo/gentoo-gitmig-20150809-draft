# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xpde/xpde-0.2.0.ebuild,v 1.1 2003/02/17 09:20:10 raker Exp $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="A Desktop Environment modelled after the O/S from Redmond, WA"
HOMEPAGE="http://www.xpde.com/"
SRC_URI="http://www.xpde.com/d2/${P}-20030215.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha"
DEPEND="virtual/x11"

src_compile() {
	einfo ""
	einfo "This is a binary-only package (sadly)"
	einfo "No files to compile."
	einfo ""
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

	dodir /opt/xpde/themes
	cp -r themes/default ${D}/opt/xpde/themes

	dodir /usr/share/doc/${P}/buildguide
	cp doc/buildguide/* ${D}/usr/share/doc/${P}/buildguide
	dodir /usr/share/doc/${P}/developers
	cp doc/developers/* ${D}/usr/share/doc/${P}/developers
	dodir /usr/share/doc/${P}/install
	cp doc/install/* ${D}/usr/share/doc/${P}/install
	dodir /usr/share/doc/${P}/planning
	cp doc/planning/* ${D}/usr/share/doc/${P}/planning

	cp *.so* XPde XPwm stub.sh ${D}/opt/xpde/bin

	cp DateTimeProps appexec networkstatus xpsu mouse \
		keyboard regional ${D}/opt/xpde/bin/applets

	cp taskmanager notepad controlpanel ${D}/opt/xpde/bin/apps

	cp -r defaultdesktop ${D}/usr/share/doc/${P}
	cp xinitrcDEFAULT ${D}/usr/share/doc/${P}

	cp ${FILESDIR}/install-config.sh ${D}/usr/share/doc/${P}
}

pkg_postinst() {
	einfo ""
	einfo "sh /usr/share/doc/${P}/install-config.sh"
	einfo ""
	einfo "This will install a default configuration into your"
	einfo "home directory"
	einfo ""
}
