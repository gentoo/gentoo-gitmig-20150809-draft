# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/blt/blt-2.4u.ebuild,v 1.5 2003/09/04 05:13:00 msterret Exp $


S="${WORKDIR}/${PN}${PV}"
SRC_URI="http://www.netsw.org/softeng/lang/tcl/BLT2.4u.tar.gz"
HOMEPAGE="http://incrtcl.sourceforge.net/blt/"
DESCRIPTION="an extension to the Tk toolkit"

DEPEND=">=dev-lang/tk-8.0"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

# hyper-optimizations untested...
#
src_compile() {

	cd ${S}
	./configure --host=${CHOST} \
				--prefix=/usr \
				--mandir=/usr/share/man \
				--infodir=/usr/share/info \
				--with-x \
				--with-tcl=/usr/lib || die "./configure failed"

	emake CFLAGS="${CFLAGS}" || die

}

src_install() {

	dodir /usr/bin
	dodir /usr/lib/blt2.4/demos/bitmaps
	dodir /usr/share/man/mann
	dodir /usr/include
	emake \
			prefix=${D}/usr \
			exec_prefix=${D}/usr \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			install || die

	dodoc NEWS PROBLEMS README
}
