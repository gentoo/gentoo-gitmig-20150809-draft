## Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Updated by AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.0-r3.ebuild,v 1.6 2002/07/16 11:36:46 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="giflib"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/libs/giflib/${P}.tar.gz
	 ftp://prtr-13.ucsc.edu/pub/libungif/${P}.tar.gz"

HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"

DEPEND="X? ( virtual/x11 )"

SLOT="0"
LICENSE="GPL"
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
		prefix=${D}/usr	\
		install || die
	
	# if gif is not in USE, then ungif is preferred
	use gif || rm -rf ${D}/usr/bin
	

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS ONEWS
	dodoc PATENT_PROBLEMS README TODO
	dodoc doc/*.txt
	dohtml -r doc

}

pkg_postinst() {

	use gif 2>/dev/null && (
		einfo "You had the gif USE flag set, so the binary from this library"
		einfo "is your gif binary.  If you would prefer to use the binary from"
		einfo "the ungif library, please unset the gif USE toggle, and remerge"
		einfo "both this and libungif"
	) || (
		einfo "You did not have the gif USE toggle set, so the binary from"
		einfo "the libungif package is assumed to be your gif binary. Please"
		einfo "make sure that you have libungif emerged."
	)
}
