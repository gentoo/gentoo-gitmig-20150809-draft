# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rox/rox-2.0.0.ebuild,v 1.2 2003/06/24 08:55:37 taviso Exp $

IUSE=""

DESCRIPTION="fast and powerful graphical file manager"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.9"

src_install() {
	cd ${S}/Choices

	dodir /usr/share/Choices
	cp -rf MIME-icons/ ${D}/usr/share/Choices/
	cp -rf MIME-types/ ${D}/usr/share/Choices/
	
	cd ${S}
	doman rox.1

	dodir /usr/bin	
	cp -rf ROX-Filer/ ${D}/usr/share/
	${D}/usr/share/ROX-Filer/AppRun --compile
	(cd ${D}/usr/share/ROX-Filer/src; make clean) > /dev/null
	echo "#!/bin/sh" > "${D}/usr/bin/rox"
	echo "exec /usr/share/ROX-Filer/AppRun \"\$@\"" >> "${D}/usr/bin/rox"
	chmod a+x ${D}/usr/bin/rox
}
