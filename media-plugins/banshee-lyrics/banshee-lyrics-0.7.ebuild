# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/banshee-lyrics/banshee-lyrics-0.7.ebuild,v 1.1 2010/01/16 22:28:04 pacho Exp $

EAPI=2

inherit mono

MY_PN="bansheelyricsplugin"

DESCRIPTION="Lyrics plugin for Banshee"
HOMEPAGE="http://code.google.com/p/bansheelyricsplugin/"
SRC_URI="http://bansheelyricsplugin.googlecode.com/files/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/banshee-1.4
	>=dev-dotnet/gtkhtml-sharp-2.24.0:2
	>=dev-dotnet/gconf-sharp-2.24.0:2"
DEPEND="${RDEPEND}
	sys-devel/libtool
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
}
