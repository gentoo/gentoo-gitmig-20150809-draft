# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.0-r1.ebuild,v 1.5 2002/07/16 11:36:48 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library for reading and writing gif images without LZW compression"
SRC_URI="ftp://prtr-13.ucsc.edu/pub/libungif/${P}.tar.gz"
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"

DEPEND="X? ( virtual/x11 )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_compile() {

	local myconf
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"
    
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		${myconf} || die

	emake || die
}

src_install() {

	make \
		prefix=${D}/usr \
		install || die

	use gif && rm -rf ${D}/usr/bin

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS ONEWS
	dodoc UNCOMPRESSED_GIF README TODO
	dodoc doc/*.txt
	dohtml -r doc
}

pkg_postinst() {

	use gif 2>/dev/null && (
		einfo "You had the gif USE flag set, so it is assumed that you want"
		einfo "the binary from giflib instead.  Please make sure you have"
		einfo "giflib emerged.  Otherwise, unset the gif flag and remerge this"
	) || (
		einfo "You did not have the gif USE flag, so your gif binary is being"
		einfo "provided by this package.  If you would rather use the binary"
		einfo "from giflib, please set the gif USE flag, and re-emerge both"
		einfo "this and giflib"
	)
}
