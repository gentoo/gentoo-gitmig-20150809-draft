# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-1.0.10.ebuild,v 1.8 2007/01/04 14:41:41 flameeyes Exp $

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="latest"

inherit eutils mono autotools

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz
		mirror://gentoo/${P}-configurable.diff.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="1"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-lang/mono-1.0
	dev-perl/XML-LibXML
	>=x11-libs/gtk+-2.2
	>=gnome-base/orbit-2.8.3"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0
	sys-devel/automake
	sys-devel/autoconf
	dev-util/pkgconfig"

KEYWORDS="amd64 ppc x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${P}-configurable.diff
	sed -i -e 's:\<PKG_PATH\>:GTK_SHARP_PKG_PATH:g' configure.in

	# Use correct libdir in pkgconfig file
	sed -i -e 's:^libdir.*:libdir=@libdir@:' \
		${S}/gtk-sharp.pc.in || die

	eautoreconf

	# disable building of samples (#16015)
	sed -i -e "s:sample::" Makefile.in
}

src_compile() {
	local myconf
	for package in art glade gnome gnomedb gda gtkhtml rsvg vte
	do
		myconf="${myconf} --disable-${package}"
	done

	econf ${myconf} || die "./configure failed"
	LANG=C emake -j1 || die
}

src_install () {
	LANG=C make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}" \
		DESTDIR=${D} install || die

	dodoc README* ChangeLog
}
