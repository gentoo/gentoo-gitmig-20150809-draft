# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pearpc/pearpc-0.2.0.ebuild,v 1.1 2004/06/18 16:16:37 port001 Exp $

IUSE="qt jit"

DESCRIPTION="PowerPC Architecture Emulator"
HOMEPAGE="http://pearpc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pearpc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-lang/nasm"

RDEPEND="virtual/x11
	media-libs/libmng
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	media-libs/freetype
	qt? ( >=x11-libs/qt-3.1.1 )"

src_compile() {
	local myconf
	myconf="--enable-release"

	use jit && myconf="${myconf} --enable-cpu=jitc_x86"
	if use qt; then
		myconf="${myconf} --enable-gui=qt"
	else
		myconf="${myconf} --enable-gui=nogui"
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/ppc
	dodoc ChangeLog AUTHORS COPYING README TODO

	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins scripts/ifppc_down scripts/ifppc_up
	doins video.x

	insinto /usr/share/doc/${P}
	sed -i -e "s:video.x:/usr/share/${P}/video.x:g" ppccfg.example
	doins ppccfg.example
}

pkg_postinst() {
	echo
	einfo "You will need to update your configuration files to point"
	einfo "to the new location of video.x, which is now"
	einfo "/usr/share/${P}/video.x"
	echo
}
