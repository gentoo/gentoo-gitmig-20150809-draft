# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-2.10.0.ebuild,v 1.10 2009/01/06 12:51:21 loki_val Exp $

inherit eutils mono autotools

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="mirror://gnome/sources/${PN}/${PV%.*}/${P}.tar.gz
		mirror://gentoo/${P}-configurable.diff.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
IUSE="doc"
RESTRICT="test"

RDEPEND=">=dev-lang/mono-1.1.9
	dev-perl/XML-LibXML
	>=x11-libs/gtk+-2.10
	>=gnome-base/orbit-2.8.3
	!dev-dotnet/atk-sharp
	!dev-dotnet/gdk-sharp
	!dev-dotnet/glib-sharp
	!dev-dotnet/gtk-dotnet-sharp
	!dev-dotnet/gtk-sharp-gapi
	!dev-dotnet/pango-sharp
	"

DEPEND="${RDEPEND}
	doc? ( >=virtual/monodoc-1.1.8 )
	dev-util/pkgconfig"

KEYWORDS="amd64 ppc ~sparc x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}/${P}-configurable.diff"

	# fixes support with pkgconfig-0.17, bug #92503
	# as well as remove zapping of CFLAGS
	sed -i -e 's/\<PKG_PATH\>/GTK_SHARP_PKG_PATH/g' \
		-e ':^CFLAGS=:d' \
		"${S}"/configure.in

	# Use correct libdir in pkgconfig files
	sed -i -e 's:^libdir.*:libdir=@libdir@:' \
		"${S}"/*/*.pc.in || die

	eautoreconf

	# disable building of samples (#16015)
	sed -i -e "s:sample::" Makefile.in
}

src_compile() {

	local myconf=""
	# These are the same as from gtk-sharp-component.eclass
	for package in art glade gnome gnomevfs gtkhtml rsvg vte
	do
		myconf="${myconf} --disable-${package}"
	done

	econf ${myconf} || die "./configure failed"
	LANG=C emake -j1 || die
}

src_install () {
	make GACUTIL_FLAGS="/root "${D}"/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}-2.0" \
		DESTDIR="${D}" install || die

	dodoc README* ChangeLog
}
