# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/blt/blt-2.4z.ebuild,v 1.11 2004/06/04 23:21:02 dholm Exp $

inherit eutils

SRC_URI="mirror://sourceforge/blt/BLT2.4z.tar.gz"
HOMEPAGE="http://blt.sf.net"
DESCRIPTION="BLT is an extension to the Tk toolkit adding new widgets, geometry managers, and miscellaneous commands."
DEPEND=">=dev-lang/tk-8.0"
IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc ~ppc"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/blt2.4z-install.diff
}

src_compile() {
	cd ${S}
	./configure --host=${CHOST} \
				--prefix=/usr \
				--mandir=/usr/share/man \
				--infodir=/usr/share/info \
				--with-x \
				--with-tcl=/usr/lib || die "./configure failed"

	emake -j1 CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/bin \
		/usr/lib/blt2.4/demos/bitmaps \
		/usr/share/man/mann \
		/usr/include \
			|| die "dodir failed"
	make INSTALL_ROOT=${D} install || die "make install failed"

	dodoc NEWS PROBLEMS README
}
