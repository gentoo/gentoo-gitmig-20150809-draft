# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pymol/pymol-0.82.ebuild,v 1.9 2003/09/02 22:45:15 liquidx Exp $

inherit eutils flag-o-matic

MY_PV=${PV/./_}
DESCRIPTION="A Python-extensible molecular graphics system."
HOMEPAGE="http://pymol.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymol/${PN}-${MY_PV}-src.tgz"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-lang/python
	dev-python/pmw
	dev-python/numeric
	dev-lang/tk
	media-libs/libpng
	sys-libs/zlib
	media-libs/glut"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp setup/Rules.linux Rules.make
	epatch ${FILESDIR}/${PN}-gentoo.diff
}

src_compile() {
	append-flags -ffast-math -funroll-loops
	make || die
}

src_install() {
	local PYMOL_PATH=/usr/lib/pymol/${PV}
	dodir /usr/lib/pymol/${PV}
	cp -a modules ${D}/usr/lib/pymol/${PV}
	dodir /usr/bin
	cat <<-EOF > ${D}/usr/bin/pymol-${PV}
	#!/bin/sh
	export PYMOL_PATH=/usr/lib/pymol/${PV}
	export TCL_LIBRARY=/usr/lib/tcl8.3
	export PYTHONPATH=/usr/lib/pymol/${PV/modules}:\${PYTHONPATH}
	python /usr/lib/pymol/${PV}/modules/launch_pymol.py \$*
	EOF
	chmod 755 ${D}/usr/bin/pymol-${PV}
	dodoc README DEVELOPERS CHANGES
	dosym /usr/bin/pymol-${PV} /usr/bin/pymol
}
