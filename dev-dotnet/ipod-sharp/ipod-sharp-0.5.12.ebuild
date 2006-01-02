# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ipod-sharp/ipod-sharp-0.5.12.ebuild,v 1.3 2006/01/02 15:54:01 metalgod Exp $

inherit mono

DESCRIPTION="ipod-sharp provides high-level feature support for Apple's iPod and binds libipoddevice."
HOMEPAGE="http://banshee-project.org/Ipod-sharp"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1.10
	doc? ( dev-util/monodoc )
	>=dev-dotnet/gtk-sharp-2.0"
DEPEND="${RDEPEND}
	>=media-libs/libipoddevice-0.3.5"

src_compile() {
	econf $(use_enable doc docs) || die "configure failed"
	emake || die "make failed"
}
src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
