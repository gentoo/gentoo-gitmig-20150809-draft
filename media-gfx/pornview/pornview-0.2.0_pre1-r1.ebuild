# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pornview/pornview-0.2.0_pre1-r1.ebuild,v 1.6 2008/04/27 21:35:01 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Image viewer/manager with optional support for MPEG movies."
HOMEPAGE="http://pornview.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 -hppa ppc x86"
IUSE="jpeg nls mplayer"

RDEPEND="media-libs/libpng
	mplayer? ( media-video/mplayer )
	jpeg? ( media-libs/jpeg )
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-4.diff \
		"${FILESDIR}"/traypatch.diff \
		"${FILESDIR}"/${P}-desktop-entry.patch
}

src_compile() {
	local myconf="--with-gtk2"

	use mplayer && myconf="${myconf} --enable-mplayer"
	use jpeg || myconf="${myconf} --disable-exif"
	use nls || myconf="${myconf} --disable-nls"

	tc-export CC
	econf ${myconf}
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" desktopdir="/usr/share/applications" \
		install || die "emake install failed."
	dodoc AUTHORS NEWS README
}
