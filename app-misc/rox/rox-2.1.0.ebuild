# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rox/rox-2.1.0.ebuild,v 1.3 2003/12/16 01:53:09 weeve Exp $

DESCRIPTION="ROX is a desktop environment, like GNOME, KDE and XFCE.  It is an attempt to bring some of the good features from RISC OS to Unix and Linux."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.9"

src_compile() {
	rm ROX-Filer/src/configure # see bug #26162
	ROX-Filer/AppRun --compile || die "make failed"
	(cd ROX-Filer/src; make clean) > /dev/null
}

src_install() {
	doman rox.1

	dodir /usr/bin
	cp -rf ROX-Filer/ ${D}/usr/share/
	echo "#!/bin/sh" > "${D}/usr/bin/rox"
	echo "exec /usr/share/ROX-Filer/AppRun \"\$@\"" >> "${D}/usr/bin/rox"
	chmod a+x ${D}/usr/bin/rox

	insinto /usr/share/mime/packages
	doins rox.xml

	dodir /usr/share/
	cp -rf Choices ${D}/usr/share/
	dodir /usr/share/Choices/Mime-icons
	keepdir /usr/share/Choices/Mime-icons

	dodir /usr/share/icons
	dosym /usr/share/ROX-Filer/ROX /usr/share/icons/ROX
}

pkg_postinst() {
	update-mime-database /usr/share/mime
}
