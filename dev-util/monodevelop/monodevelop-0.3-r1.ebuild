# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-0.3-r1.ebuild,v 1.1 2004/05/06 15:11:47 latexer Exp $

inherit mono

DESCRIPTION="MonoDevelop is a project to port SharpDevelop to Gtk#"
SRC_URI="http://go-mono.com/archive/beta1/${P}.tar.gz"
HOMEPAGE="http://monodevelop.com/"
LICENSE="GPL-2"

IUSE="nptl"
DEPEND=">=dev-libs/icu-2.8
	>=dev-dotnet/gtksourceview-sharp-0.2
	>=dev-dotnet/gecko-sharp-0.3
	>=dev-dotnet/mono-0.91
	>=dev-util/monodoc-0.15
	>=x11-libs/gtk-sharp-0.91.1"

KEYWORDS="~x86"
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
