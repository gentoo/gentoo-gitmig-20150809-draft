# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-subtitles/gnome-subtitles-0.0.3.ebuild,v 1.1 2006/12/01 07:06:45 beandog Exp $

inherit mono

DESCRIPTION="Movie subtitling for the Gnome desktop"
HOMEPAGE="http://gsubtitles.sourceforge.net/"
SRC_URI="mirror://sourceforge/gsubtitles/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-lang/mono-1.1
	>=dev-dotnet/gnome-sharp-2.8
	>=dev-dotnet/glade-sharp-2.8"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog CREDITS NEWS README TODO
}
