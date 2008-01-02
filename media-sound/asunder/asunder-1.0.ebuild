# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/asunder/asunder-1.0.ebuild,v 1.1 2008/01/02 15:19:22 drac Exp $

inherit eutils

DESCRIPTION="Asunder is a graphical CD ripper and encoder"
HOMEPAGE="http://littlesvr.ca/asunder"
SRC_URI="http://littlesvr.ca/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="flac mp3 vorbis"

RDEPEND=">=x11-libs/gtk+-2.4
	>=media-libs/libcddb-0.9.5
	media-sound/cdparanoia
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-desktop-entry.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
