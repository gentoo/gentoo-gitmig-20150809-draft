# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/webkit-sharp/webkit-sharp-0.2.ebuild,v 1.5 2009/04/30 14:43:48 ranger Exp $

inherit mono

DESCRIPTION="WebKit-gtk bindings for Mono"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://mono.ximian.com/monobuild/preview/sources/webkit-sharp/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/mono-2
	net-libs/webkit-gtk
	>=dev-dotnet/gtk-sharp-2"

RDEPEND="${DEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_install() {
	    emake DESTDIR="${D}" install || die "Install failed"
	    dodoc README ChangeLog || die
}
