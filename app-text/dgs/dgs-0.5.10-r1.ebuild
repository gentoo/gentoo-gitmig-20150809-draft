# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/dgs/dgs-0.5.10-r1.ebuild,v 1.9 2002/08/02 17:42:49 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Ghostscript based DPS server"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dgs/${P}.tar.gz"
HOMEPAGE="http://www.aist-nara.ac.jp/~masata-y/dgs/index.html"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc sys-apps/texinfo
	      >=sys-apps/tcp-wrappers-7.6
	=dev-libs/glib-1.2*
	virtual/x11"

RDEPEND="virtual/glibc
 	=dev-libs/glib-1.2*
	virtual/x11"

KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gs-time_.h-gentoo.diff
}

src_compile() {

	  econf "--with-x" || die
	  make || die

}

src_install () {

	  einstall || die
	
	  dodoc ANNOUNCE ChangeLog FAQ NEWS NOTES README STATUS TODO Version
}
