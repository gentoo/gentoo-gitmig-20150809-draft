# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/pymol/pymol-0.82.ebuild,v 1.1 2002/07/20 02:58:05 george Exp $

A="pymol-0_82-src.tgz"
S="$WORKDIR/${P}"
DESCRIPTION="A Python-extensible molecular graphics system."
SRC_URI="http://download.sourceforge.net/pymol/${A}"
HOMEPAGE="http://pymol.sf.net"
LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-lang/python
	dev-python/pmw
	dev-python/Numeric
	dev-lang/tk
	media-libs/libpng
	sys-libs/zlib
	media-libs/glut
	"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp setup/Rules.linux Rules.make
	patch -p0 < ${FILESDIR}/${PN}-gentoo.diff || die
}

src_compile() {
	CFLAGS="$CFLAGS -ffast-math -funroll-loops"
	make || die
}


src_install() 
{
	local PYMOL_PATH=/usr/lib/pymol/${PV}
	mkdir -p ${D}/usr/lib/pymol/${PV}
	cp -a modules ${D}/usr/lib/pymol/${PV}
	mkdir -p ${D}/usr/bin
	cat <<-EOF > ${D}/usr/bin/pymol-${PV}
	#!/bin/sh
	export PYMOL_PATH=/usr/lib/pymol/${PV}
	export TCL_LIBRARY=/usr/lib/tcl8.3
	export PYTHONPATH=/usr/lib/pymol/${PV/modules}:\${PYTHONPATH}
	python /usr/lib/pymol/${PV}/modules/launch_pymol.py \$*
	EOF
	chmod 755 ${D}/usr/bin/pymol-${PV}
	dodoc README DEVELOPERS CHANGES
	cd ${D}/usr/bin
	ln -fs pymol-${PV} pymol
}


