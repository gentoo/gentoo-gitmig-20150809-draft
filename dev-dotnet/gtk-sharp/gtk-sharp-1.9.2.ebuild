# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-1.9.2.ebuild,v 1.1 2005/04/02 01:09:10 latexer Exp $

inherit eutils mono

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
		mirror://gentoo/${P}-configurable.diff.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
IUSE=""

RDEPEND=">=sys-apps/sed-4.0
	>=dev-lang/mono-1.1.2
	>=x11-libs/gtk+-2.4
	>=gnome-base/orbit-2.8.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KEYWORDS="~x86 ~ppc ~ppc"

src_unpack() {
	unpack ${A}

	# disable building of samples (#16015)
	cd ${S}
	epatch ${WORKDIR}/${P}-configurable.diff
	export WANT_AUTOMAKE="1.8"
	aclocal || die
	automake || die
	autoconf || die
	libtoolize --copy --force

	sed -i -e "s:sample::" Makefile.in
}

src_compile() {

	local myconf=""
	# These are the same as from gtk-sharp-component.eclass
	for package in art gda glade gnome gnomedb gnomevfs gtkhtml rsvg vte
	do
		myconf="${myconf} --disable-${package}"
	done

	econf ${myconf} || die "./configure failed"
	LANG=C emake -j1 || die
}

src_install () {
	make GACUTIL_FLAGS="/root ${D}/usr/lib /gacdir /usr/lib /package ${PN}-2.0" \
		DESTDIR=${D} install || die

	dodoc README* ChangeLog
}
