# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-1.0.8.ebuild,v 1.6 2005/08/05 02:08:20 latexer Exp $

inherit eutils mono

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
		mirror://gentoo/${P}-configurable.diff.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="1"
IUSE=""
RESTRICT="test"

RDEPEND=">=sys-apps/sed-4.0
	>=dev-lang/mono-1.0
	sys-devel/automake
	sys-devel/autoconf
	>=x11-libs/gtk+-2.2
	>=gnome-base/orbit-2.8.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KEYWORDS="~amd64 ppc x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${P}-configurable.diff
	sed -i -e 's:\<PKG_PATH\>:GTK_SHARP_PKG_PATH:g' configure.in

	aclocal || die
	# See bug #73563, comment #9
	libtoolize --copy --force || die
	autoconf || die
	automake || die

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
