# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-vala/monodevelop-vala-2.4-r1.ebuild,v 1.3 2011/05/11 19:30:59 angelos Exp $

EAPI=2

inherit mono multilib versionator

DESCRIPTION="Vala Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://ftp.novell.com/pub/mono/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.4
	=dev-util/monodevelop-$(get_version_component_range 1-2)*
	>=dev-dotnet/mono-addins-0.4[gtk]
	>=dev-dotnet/glib-sharp-2.12.9
	>=dev-dotnet/gtk-sharp-2.12.9
	>=dev-dotnet/glade-sharp-2.12.9
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnomevfs-sharp-2.24.0
	>=dev-dotnet/gconf-sharp-2.24.0
	dev-lang/vala:0.10"

DEPEND="${RDEPEND}
	x11-misc/shared-mime-info
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19"

src_prepare() {
	# Doesn't really require so old vala:0, see upstream bug #667923
	sed -i -e s:valac:$(type -P valac-0.10): Compiler/ValaCompiler.cs \
		templates/Makefile.am.template templates/Makefile.template || die
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog README || die "dodoc failed"
	mono_multilib_comply
}
