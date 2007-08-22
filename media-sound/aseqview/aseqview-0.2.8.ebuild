# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aseqview/aseqview-0.2.8.ebuild,v 1.4 2007/08/22 18:46:16 jurek Exp $

DESCRIPTION="ALSA sequencer event viewer/filter."
HOMEPAGE="http://www.alsa-project.org/~iwai/alsa.html"
SRC_URI="http://ftp.suse.com/pub/people/tiwai/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=media-libs/alsa-lib-0.9.0
	>=x11-libs/gtk+-2
	net-libs/libpcap"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --disable-alsatest --disable-gtktest --enable-gtk2
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
