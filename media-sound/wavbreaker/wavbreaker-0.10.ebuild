# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.10.ebuild,v 1.2 2008/06/14 12:32:36 drac Exp $

inherit autotools eutils

DESCRIPTION="wavbreaker/wavmerge GTK+ utility to break or merge WAV files"
HOMEPAGE="http://wavbreaker.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa nls oss pulseaudio"

RDEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-pkgconfig.patch
	eautoreconf
}

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable alsa) \
		$(use_enable pulseaudio pulse) \
		$(use_enable oss)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog CONTRIBUTORS NEWS README* TODO
}
