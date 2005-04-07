# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox/rox-2.2.0.ebuild,v 1.6 2005/04/07 16:53:51 blubb Exp $

DESCRIPTION="ROX is a desktop environment, like GNOME, KDE and XFCE.  It is an attempt to bring some of the good features from RISC OS to Unix and Linux."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc amd64"

DEPEND=">=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	>=dev-libs/libxml2-2.4.23
	>=x11-misc/shared-mime-info-0.9
	svg? ( gnome-base/librsvg )"

IUSE="svg"

src_compile() {
#	rm ROX-Filer/src/configure # see bug #26162

	# If the env variable PLATFORM is set, rox will build using that
	# string.  This causes issues as while the package will compile fine,
	# it will try to rebuild it the first time rox is run because it will
	# not be able to find a proper executable to run.
	use sparc && unset PLATFORM

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
