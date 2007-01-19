# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pornview/pornview-0.2.0_pre1-r1.ebuild,v 1.3 2007/01/19 15:30:46 masterdriverz Exp $

inherit eutils

IUSE="jpeg mplayer nls static"

DESCRIPTION="Image viewer/manager with optional support for MPEG movies."
HOMEPAGE="http://pornview.sourceforge.net"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	mplayer? ( media-video/mplayer )
	jpeg? ( media-libs/jpeg )
	>=x11-libs/gtk+-2.0
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

SLOT="0"
KEYWORDS="x86 ppc amd64"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"

S="${WORKDIR}/${P/_/}"

src_compile() {
	local myflags

	myflags="${myflags} --with-gtk2"

	if use mplayer; then
	  myflags="${myflags} --enable-mplayer"
	fi

	use jpeg || myflags="${myflags} --disable-exif"

	use nls || myflags="${myflags} --disable-nls"

	use static && myflags="${myflags} --enable-static"

	epatch ${FILESDIR}/${P}-4.diff || die
	epatch ${FILESDIR}/traypatch.diff || die

	econf ${myflags} || die "./configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS README
}
