# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <george@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/uudeview/uudeview-0.5.13.ebuild,v 1.1 2002/06/06 08:27:48 george Exp $


S="${WORKDIR}/${P}"
DESCRIPTION="uu, xx, base64, binhex decoder"
SRC_URI="http://ibiblio.org/pub/Linux/utils/text/${P}.tar.gz"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
LICENSE="GPL-2"
DEPEND="tcltk?  ( dev-lang/tcl dev-lang/tk )"
RDEPEND="${DEPEND}"

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
