# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.3.ebuild,v 1.9 2005/07/19 23:44:45 kloeri Exp $

inherit eutils

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="http://sourceforge.net/projects/libungif/"
SRC_URI="mirror://sourceforge/libungif/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc-macos ppc64 s390 sparc x86"
IUSE="X gif"

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	epunt_cxx
}

src_compile() {
	econf $(use_with X x) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# if gif is not in USE, then ungif is preferred
	use gif || rm -r "${D}"/usr/bin "${D}"/usr/include/gif_lib.h

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
