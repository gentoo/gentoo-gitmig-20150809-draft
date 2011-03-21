# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono-addins/mono-addins-0.6.ebuild,v 1.2 2011/03/21 20:23:56 ranger Exp $

EAPI=2

inherit mono multilib

DESCRIPTION="A generic framework for creating extensible applications"
HOMEPAGE="http://www.mono-project.com/Mono.Addins"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="+gtk"

RDEPEND=">=dev-lang/mono-2
	gtk? (  >=dev-dotnet/gtk-sharp-2.0 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19"

src_configure() {
	econf $(use_enable gtk gui)
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
	mono_multilib_comply
}
