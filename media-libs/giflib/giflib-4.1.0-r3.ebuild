# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.0-r3.ebuild,v 1.23 2004/03/07 15:37:19 geoman Exp $

inherit gnuconfig

IUSE="X gif"

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="http://prtr-13.ucsc.edu/~badger/software/libungif/index.shtml"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/libs/giflib/${P}.tar.gz
	 ftp://prtr-13.ucsc.edu/pub/libungif/${P}.tar.gz"

SLOT="0"
LICENSE="as-is | BSD"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips"

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	use alpha && gnuconfig_update
	use hppa && gnuconfig_update
	use amd64 && gnuconfig_update
	use ia64 && gnuconfig_update
}

src_compile() {
	econf `use_with x` || die
	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr install || die "make install failed"

	# if gif is not in USE, then ungif is preferred
	use gif || rm -rf "${D}/usr/bin"

	dodoc AUTHORS BUGS ChangeLog NEWS ONEWS PATENT_PROBLEMS \
		README TODO doc/*.txt || die "dodoc failed"
	dohtml -r doc || die "dohtml failed"
}

pkg_postinst() {
	if use gif ; then
		einfo "You had the gif USE flag set, so the binary from this library"
		einfo "is your gif binary.  If you would prefer to use the binary from"
		einfo "the ungif library, please unset the gif USE toggle, and remerge"
		einfo "both this and libungif"
	else
		einfo "You did not have the gif USE toggle set, so the binary from"
		einfo "the libungif package is assumed to be your gif binary. Please"
		einfo "make sure that you have libungif emerged."
	fi
}
