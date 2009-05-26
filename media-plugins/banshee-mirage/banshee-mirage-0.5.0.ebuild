# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/banshee-mirage/banshee-mirage-0.5.0.ebuild,v 1.1 2009/05/26 09:47:03 loki_val Exp $

EAPI=2

inherit mono

MY_PN="mirage"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Automatic Playlist Generation Extension for Banshee"
HOMEPAGE="http://hop.at/mirage/"
SRC_URI="http://hop.at/${MY_PN}/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=media-sound/banshee-1.4
	sci-libs/fftw:3.0
	dev-db/sqlite:3
	dev-libs/glib:2
	media-libs/libsamplerate
	>=dev-dotnet/gtk-sharp-2.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf --disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	dodoc ChangeLog README || die
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
