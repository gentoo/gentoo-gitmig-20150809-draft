# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ipod-sharp/ipod-sharp-0.6.3.ebuild,v 1.3 2007/08/15 23:57:32 dertobi123 Exp $

inherit mono

DESCRIPTION="ipod-sharp provides high-level feature support for Apple's iPod and binds libipoddevice."
HOMEPAGE="http://banshee-project.org/Ipod-sharp"
SRC_URI="http://www.snorp.net/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1.10
	doc? ( >=dev-util/monodoc-1.1.8 )
	>=dev-dotnet/gtk-sharp-2.0"
DEPEND="${RDEPEND}
	>=media-libs/libipoddevice-0.5.0"

src_compile() {
	econf $(use_enable doc docs) || die "configure failed"
	emake || die "make failed"
}
src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
