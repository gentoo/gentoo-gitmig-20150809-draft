# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giflib/giflib-4.1.4.ebuild,v 1.5 2005/10/30 10:52:10 blubb Exp $

inherit eutils

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="http://sourceforge.net/projects/libungif/"
SRC_URI="mirror://sourceforge/libungif/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ~ppc-macos ~ppc64 s390 sh ~x86"
IUSE="rle X"

DEPEND="X? ( virtual/x11 )
	rle? ( media-libs/urt )
	!media-libs/libungif"

src_unpack() {
	unpack ${A}
	epunt_cxx
}

yesno() { use $1 && echo yes || echo no ; }
src_compile() {
	export \
		ac_cv_lib_gl_s_main=no \
		ac_cv_lib_rle_rle_hdr_init=$(yesno rle) \
		ac_cv_lib_X11_main=$(yesno X)
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog NEWS ONEWS README TODO doc/*.txt
	dohtml -r doc
}
