# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/treewm/treewm-0.4.3.ebuild,v 1.1 2003/09/10 15:23:15 tseng Exp $

DESCRIPTION="WindowManager that arranges the windows in a tree (not in a list)"
SRC_URI="http://www.informatik.uni-frankfurt.de/~polzer/treewmdurchnull/downloads/${PN}-${PV}.tar.bz2"
HOMEPAGE="http://treewm.sourceforge.net/"
S="${WORKDIR}/${PN}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="virtual/glibc virtual/x11"

RDEPEND="virtual/glibc virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	PREFIX="/usr" ROOT="${D}" FEATURES="-DXF86VIDMODE -DSHAPE" emake || die
}

src_install() {
	cd ${S}
	PREFIX="/usr" ROOT="${D}" FEATURES="-DXF86VIDMODE -DSHAPE" make install || die

	# hack for Gentoo's doc policy:
	cd "${D}/usr/share/doc/treewm" && dodoc * && cd .. && rm -rf treewm || die
}
