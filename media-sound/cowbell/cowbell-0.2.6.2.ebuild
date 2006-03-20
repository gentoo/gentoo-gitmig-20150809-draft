# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cowbell/cowbell-0.2.6.2.ebuild,v 1.2 2006/03/20 00:46:38 metalgod Exp $

inherit autotools gnome2 mono

DESCRIPTION="Elegantly tag and rename mp3/ogg/flac files"
SRC_URI="http://more-cowbell.org/releases/${P}.tar.gz"
HOMEPAGE="http://more-cowbell.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/mono
	>=dev-dotnet/gtk-sharp-2.6
	>=dev-dotnet/glade-sharp-2.6
	>=media-libs/taglib-1.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile() {
	eautoreconf

	gnome2_src_configure
	emake -j1 || die "make failed"
}
