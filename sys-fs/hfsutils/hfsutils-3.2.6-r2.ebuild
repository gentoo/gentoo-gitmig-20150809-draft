# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsutils/hfsutils-3.2.6-r2.ebuild,v 1.7 2006/09/19 02:11:06 cardoe Exp $

inherit eutils

DESCRIPTION="HFS FS Access utils"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~x86"
IUSE="tcl tk"

DEPEND="virtual/libc
	tcl? ( dev-lang/tcl )
	tk? ( dev-lang/tk )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/hfsutils-3.2.6-errno.patch
}

src_compile() {
	local myconf
	use tcl && myconf="--with-tcl"
	use tk && myconf="--with-tk"

	econf ${myconf} || die
	emake PREFIX=/usr MANDIR=/usr/share/man || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man/man1
	make \
		prefix=${D}/usr \
		MANDEST=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}
