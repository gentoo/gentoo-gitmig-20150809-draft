# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.8.1.ebuild,v 1.4 2007/08/27 14:54:47 angelos Exp $

inherit eutils

DESCRIPTION="wavbreaker/wavmerge GTK+ utility to break or merge WAV files"
HOMEPAGE="http://wavbreaker.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa nls oss"

RDEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable alsa) $(use_enable oss) \
		$(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog CONTRIBUTORS NEWS README TODO
}
