# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/njb-sharp/njb-sharp-0.3.0.ebuild,v 1.4 2007/08/24 03:25:02 metalgod Exp $

inherit mono

DESCRIPTION="njb-sharp provides C# bindings for libnjb, to provide NJB Digital Audio Player (DAP) support to Mono applications."
HOMEPAGE="http://www.banshee-project.org/Subprojects/Njb-sharp"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1.10
	doc? ( >=dev-util/monodoc-1.1.8 )
	>=dev-dotnet/gtk-sharp-2.0"
DEPEND="${RDEPEND}
	>=media-libs/libnjb-2.2.4"

src_compile() {
	econf $(use_enable doc docs) || die "configure failed"
	emake -j1 || die "make failed"
}
src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
