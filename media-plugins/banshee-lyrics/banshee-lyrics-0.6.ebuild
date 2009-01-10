# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/banshee-lyrics/banshee-lyrics-0.6.ebuild,v 1.1 2009/01/10 21:39:14 loki_val Exp $

EAPI=2

inherit mono

MY_PN="BansheeLyricsPlugin"

DESCRIPTION="Lyrics plugin for Banshee"
HOMEPAGE="http://bansheelyricsplugin.googlecode.com/"
SRC_URI="http://ppa.launchpad.net/banshee-team/ubuntu/pool/main/b/banshee-extension-lyrics/banshee-extension-lyrics_0.6.ubuntu1.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/banshee-1.4
	dev-dotnet/gtkhtml-sharp:2
	dev-dotnet/gconf-sharp:2"
DEPEND="${RDEPEND}
	sys-devel/libtool
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-1.0"

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
}
