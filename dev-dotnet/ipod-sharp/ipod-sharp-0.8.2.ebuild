# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ipod-sharp/ipod-sharp-0.8.2.ebuild,v 1.1 2009/01/25 11:38:53 loki_val Exp $

EAPI=2

inherit mono

DESCRIPTION="ipod-sharp provides high-level feature support for Apple's iPod and binds libipoddevice."
HOMEPAGE="http://banshee-project.org/Ipod-sharp"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/mono-2.0
	dev-dotnet/dbus-glib-sharp
	>=dev-dotnet/podsleuth-0.6.4"
DEPEND="${RDEPEND}
	doc? ( >=virtual/monodoc-1.1.8 )
	dev-util/pkgconfig"

src_configure() {
	econf $(use_enable doc docs)
}

src_compile() {
	emake -j1 || die "emake failed."
}
src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
