# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-0.5.1.ebuild,v 1.2 2004/10/26 21:53:22 latexer Exp $

inherit mono eutils

DESCRIPTION="MonoDevelop is a project to port SharpDevelop to Gtk#"
SRC_URI="http://www.go-mono.com/archive/1.0.2/${P}.tar.gz"
HOMEPAGE="http://monodevelop.com/"
LICENSE="GPL-2"

IUSE=""
DEPEND=">=dev-dotnet/gtksourceview-sharp-0.5
	>=dev-dotnet/gecko-sharp-0.5-r2
	>=dev-dotnet/mono-1.0.1
	>=dev-util/monodoc-1.0.1
	>=dev-dotnet/gtk-sharp-1.0.1"

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

pkg_postinst() {
	echo
	ewarn "If you experience problems with syntax highlighting,"
	ewarn "Re-emerge gtksourceview. Previous versions of monodevelop"
	ewarn "installed a .lang file that gtksourceview now handles."
	echo
}
