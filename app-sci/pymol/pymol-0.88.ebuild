# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pymol/pymol-0.88.ebuild,v 1.1 2003/06/20 04:53:29 george Exp $

DESCRIPTION="A Python-extensible molecular graphics system."
SRC_URI="mirror://sourceforge/pymol/${PN}-${PV/./_}-src.tgz"
HOMEPAGE="http://pymol.sf.net"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-lang/python
	dev-python/pmw
	dev-python/Numeric
	dev-lang/tk
	media-libs/libpng
	sys-libs/zlib
	media-libs/glut"

inherit distutils

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/setup2.py-gentoo.patch
	# Turn off splash screen.  Please do make a project contribution
	# if you are able though.
	[[ -n "$WANT_NOSPLASH" ]] && epatch ${FILESDIR}/nosplash-gentoo.patch
}

src_install() {
	distutils_src_install
	cd ${S}
	${python} setup2.py

	local sedexp="s:${D%/}::g"
	sed -e ${sedexp} pymol.com > pymol
	exeinto /usr/bin
	doexe pymol
	dodoc DEVELOPERS CHANGES
}
