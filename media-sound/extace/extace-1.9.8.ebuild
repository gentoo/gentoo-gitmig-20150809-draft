# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/extace/extace-1.9.8.ebuild,v 1.5 2011/03/12 09:00:30 radhermit Exp $

EAPI=1

inherit eutils

DESCRIPTION="eXtace is an ESD audio visualization application"
HOMEPAGE="http://extace.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	sci-libs/fftw:3.0
	media-sound/esound"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog CREDITS NEWS README TODO
	rm -rf "${D}"/usr/share/gnome
	newicon src/logo.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Extace Waveform Display" ${PN}
}
