# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rox/rox-2.0.1.ebuild,v 1.2 2003/09/05 12:10:36 msterret Exp $

IUSE=""

DESCRIPTION="ROX is a desktop environment, like GNOME, KDE and XFCE.  It is an attempt to bring some of the good features from RISC OS to Unix and Linux."
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
	rm ${D}/usr/share/ROX-Filer/src/configure # see bug #26162

	${D}/usr/share/ROX-Filer/AppRun --compile
	(cd ${D}/usr/share/ROX-Filer/src; make clean) > /dev/null
	echo "#!/bin/sh" > "${D}/usr/bin/rox"
	echo "exec /usr/share/ROX-Filer/AppRun \"\$@\"" >> "${D}/usr/bin/rox"
	chmod a+x ${D}/usr/bin/rox
}
