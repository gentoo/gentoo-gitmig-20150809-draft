# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/rox/rox-1.2.0.ebuild,v 1.6 2002/07/25 19:18:34 seemant Exp $

S=${WORKDIR}/${P}
HOMEPAGE="http://rox.sourceforge.net"
DESCRIPTION="ROX-Filer is a fast and powerful graphical file manager"
SRC_URI="mirror://sourceforge/rox/rox-base-1.0.1.tgz
	mirror://sourceforge/rox/${P}.tgz"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.13
	dev-libs/libxml2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_install() {

	# libxml2 header fix
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml -I/usr/include/libxml2"

	cd ${WORKDIR}/rox-base-1.0.1/Choices
	mkdir -p ${D}/usr/share/Choices
	cp -rf MIME-icons/ ${D}/usr/share/Choices/
	cp -rf MIME-info/ ${D}/usr/share/Choices/
	cp -rf MIME-types/ ${D}/usr/share/Choices/
	
	cd ${WORKDIR}/${P}
	doman rox.1
	mkdir -p ${D}/usr/share/rox
	mkdir -p ${D}/usr/bin	
	cp -rf ROX-Filer/ ${D}/usr/share/
	${D}/usr/share/ROX-Filer/AppRun --compile
	echo "#!/bin/sh" > "${D}/usr/bin/rox"
	echo "exec /usr/share/ROX-Filer/AppRun \"\$@\"" >> "${D}/usr/bin/rox"
	chmod a+x ${D}/usr/bin/rox

}
