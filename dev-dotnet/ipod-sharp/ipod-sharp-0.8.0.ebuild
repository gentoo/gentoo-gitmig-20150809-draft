# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ipod-sharp/ipod-sharp-0.8.0.ebuild,v 1.1 2008/01/27 15:56:59 drac Exp $

inherit mono

DESCRIPTION="ipod-sharp provides high-level feature support for Apple's iPod and binds libipoddevice."
HOMEPAGE="http://banshee-project.org/Ipod-sharp"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1.10
	>=dev-dotnet/gtk-sharp-2
	dev-dotnet/dbus-glib-sharp
	>=media-libs/libipoddevice-0.5.3
	>=dev-dotnet/podsleuth-0.6"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/monodoc-1.1.8 )
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable doc docs)
	emake -j1 || die "emake failed."
}
src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
