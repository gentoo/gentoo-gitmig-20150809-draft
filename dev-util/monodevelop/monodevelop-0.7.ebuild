# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-0.7.ebuild,v 1.4 2005/05/23 18:00:14 latexer Exp $

inherit mono eutils

DESCRIPTION="MonoDevelop is a project to port SharpDevelop to Gtk#"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://monodevelop.com/"
LICENSE="GPL-2"

IUSE="boo java"
DEPEND=">=dev-dotnet/gtksourceview-sharp-0.10
	>=dev-dotnet/gecko-sharp-0.10
	>=dev-lang/mono-1.1.4
	>=dev-util/monodoc-1.0
	>=dev-dotnet/gtk-sharp-1.9.5
	>=dev-dotnet/gnomevfs-sharp-1.9.5
	>=dev-dotnet/gnome-sharp-1.9.5
	>=dev-dotnet/gconf-sharp-1.9.5
	>=dev-dotnet/gtkhtml-sharp-1.9.5
	>=dev-dotnet/glade-sharp-1.9.5
	>=sys-devel/automake-1.8
	boo? ( dev-lang/boo )
	java? ( || ( >=dev-dotnet/ikvm-bin-0.14 >=dev-dotnet/ikvm-0.14.0.1-r1 ) )"

KEYWORDS="~x86 ~amd64"
SLOT="0"

src_compile() {
	econf $(use_enable boo) $(use_enable java) || die
	emake -j1 || die
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
	ewarn "${P} is affected by a bug in gtk-sharp which makes it"
	ewarn "crash horribly when loading any project referencing the"
	ewarn "gtk-sharp-1.0.x assemblies. If you absolutly need to use"
	ewarn "monodevelop to compile such projects, use ${PN}-0.5.x with"
	ewarn "mono-1.0.x"
	echo
}
