# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uudeview/uudeview-0.5.18.ebuild,v 1.3 2002/12/14 23:20:49 hanno Exp $

IUSE="tcltk"

S="${WORKDIR}/${P}"
DESCRIPTION="uu, xx, base64, binhex decoder"

SRC_URI="http://www.fpx.de/fp/Software/UUDeview/download/${P}.tar.gz"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
KEYWORDS="x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"
DEPEND="tcltk?  ( dev-lang/tcl dev-lang/tk )"

src_compile() {
	local myconf
	use tcltk || myconf="--disable-tcl --disable-tk"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		${myconf} \
		--mandir=${D}/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		install || die

	# Install documentation.
	dodoc COPYING INSTALL README
}
