# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-0.4-r1.ebuild,v 1.4 2004/10/26 21:53:22 latexer Exp $

inherit mono

DESCRIPTION="MonoDevelop is a project to port SharpDevelop to Gtk#"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"
HOMEPAGE="http://monodevelop.com/"
LICENSE="GPL-2"

IUSE=""
DEPEND=">=dev-libs/icu-2.6
	>=dev-dotnet/gtksourceview-sharp-0.3
	>=dev-dotnet/gecko-sharp-0.5
	>=dev-dotnet/mono-0.96
	>=dev-util/monodoc-0.16
	>=dev-dotnet/gtk-sharp-0.98"

KEYWORDS="~x86 ~ppc"
SLOT="0"

src_compile() {
	econf || die
	MAKEOPTS="-j1" make || die
}

src_install () {
	# Needed if update-mime-info is run
	addwrite ${ROOT}/usr/share/mime

	make DESTDIR=${D} install || die

	# Install documentation.
	dodoc ChangeLog README
}
