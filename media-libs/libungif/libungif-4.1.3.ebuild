# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libungif/libungif-4.1.3.ebuild,v 1.1 2004/09/30 09:38:11 usata Exp $

inherit eutils libtool

DESCRIPTION="A library for reading and writing gif images without LZW compression"
HOMEPAGE="http://sourceforge.net/projects/libungif/"
SRC_URI="mirror://sourceforge/libungif/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~ppc-macos"
IUSE="X gif"

RDEPEND="X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57"

src_compile() {
	elibtoolize || die

	local myconf
	use alpha && myconf="${myconf} --host=alpha-unknown-linux-gnu"
	econf `use_with X x` ${myconf} || die
	emake -j1 || die
}

src_install() {
	make prefix=${D}/usr install || die

	use gif && rm -rf "${D}/usr/bin" "${D}/usr/include/gif_lib.h"

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS ONEWS UNCOMPRESSED_GIF \
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
