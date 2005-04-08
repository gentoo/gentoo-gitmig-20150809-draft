# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.3.ebuild,v 1.10 2005/04/08 19:25:43 corsair Exp $

inherit eutils libtool

DESCRIPTION="A library for reading and writing gif images without LZW compression"
HOMEPAGE="http://sourceforge.net/projects/libungif/"
SRC_URI="mirror://sourceforge/libungif/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 ~ppc-macos sparc x86"
IUSE="X gif"

RDEPEND="X? ( virtual/x11 )
	gif? ( media-libs/giflib )"

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

	use gif && rm -r "${D}"/usr/bin "${D}"/usr/include/gif_lib.h

	dodoc AUTHORS BUGS ChangeLog NEWS ONEWS UNCOMPRESSED_GIF \
		README TODO doc/*.txt || die "dodoc failed"
	dohtml -r doc || die "dohtml failed"
}

pkg_postinst() {
	if use gif ; then
		einfo "You had the gif USE flag set, so it is assumed that you want"
		einfo "the binary from giflib instead.  Please make sure you have"
		einfo "giflib emerged.  Otherwise, unset the gif flag and remerge this"
	else
		einfo "You did not have the gif USE flag, so your gif binary is being"
		einfo "provided by this package.  If you would rather use the binary"
		einfo "from giflib, please set the gif USE flag, and re-emerge both"
		einfo "this and giflib"
	fi
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
