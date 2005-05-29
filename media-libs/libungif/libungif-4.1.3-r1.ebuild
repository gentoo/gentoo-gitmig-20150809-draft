# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.3-r1.ebuild,v 1.1 2005/05/29 03:27:29 usata Exp $

inherit eutils libtool

DESCRIPTION="A library for reading and writing gif images without LZW compression"
HOMEPAGE="http://sourceforge.net/projects/libungif/"
SRC_URI="mirror://sourceforge/libungif/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="X"

RDEPEND="X? ( virtual/x11 )
	>=media-libs/giflib-4.1.3-r1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize || die
	epunt_cxx
}

src_compile() {
	export WANT_AUTOCONF=2.5
	econf $(use_with X x) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	rm -r "${D}"/usr/bin "${D}"/usr/include/gif_lib.h

	dodoc AUTHORS BUGS ChangeLog NEWS ONEWS UNCOMPRESSED_GIF \
		README TODO doc/*.txt || die "dodoc failed"
	dohtml -r doc || die "dohtml failed"
}

src_test() {
	if has_version 'media-gfx/xv' ; then
		if [ -z "$DISPLAY" ] || ! (/usr/X11R6/bin/xhost &>/dev/null) ; then
			ewarn
			ewarn "You are not authorised to conntect to X server to make check."
			ewarn "Disabling make check."
			ewarn
			epause; ebeep; epause
		else
			make check || die "make check failed"
		fi
	else
		ewarn
		ewarn "You need media-gfx/xv to run src_test for this package."
		ewarn
		epause; ebeep; epause
	fi
}
