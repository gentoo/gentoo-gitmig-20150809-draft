# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# /home/cvsroot/gentoo-x86/app-misc/rox/rox-1.1.8.ebuild $

HOMEPAGE="http://rox.sourceforge.net"
DESCRIPTION="ROX-Filer is a fast and powerful graphical file manager"

S=${WORKDIR}/${P}
SRC_URI="http://prdownloads.sourceforge.net/rox/rox-base-1.0.1.tgz
	http://prdownloads.sourceforge.net/rox/${P}.tgz"

DEPEND="virtual/glibc
	>=x11-base/xfree-4.0.3
	>=x11-libs/gtk+-1.2.10
	>=media-libs/gdk-pixbuf-0.13
	dev-libs/libxml2"

RDEPEND="${DEPEND}"

src_install() {

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
