# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/treewm/treewm-0.4.5.ebuild,v 1.3 2004/02/18 15:22:36 lordvan Exp $

DESCRIPTION="WindowManager that arranges the windows in a tree (not in a list)"
SRC_URI="mirror://sourceforge/treewm/${PN}-${PV}.tar.bz2"
HOMEPAGE="http://treewm.sourceforge.net/"
S="${WORKDIR}/${PN}-${PV}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/glibc
		virtual/x11"

RDEPEND="virtual/glibc
		 virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	emake PREFIX="/usr" ROOT="${D}" || die
}

src_install() {
	cd ${S}
	make PREFIX="/usr" ROOT="${D}" install || die

	# hack for Gentoo's doc policy:
	cd "${D}/usr/share/doc/treewm" && dodoc * && cd .. && rm -rf treewm || die
}
