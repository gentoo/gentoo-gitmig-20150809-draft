# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-1.0.4-r1.ebuild,v 1.1 2004/11/19 03:04:19 latexer Exp $

inherit eutils mono

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz
		mirror://gentoo/${P}-configurable.diff.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="1"
IUSE=""

RDEPEND=">=sys-apps/sed-4.0
	>=dev-dotnet/mono-${PV}
	sys-devel/automake
	sys-devel/autoconf
	>=x11-libs/gtk+-2.2
	>=gnome-base/orbit-2.8.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KEYWORDS="~x86 ~ppc"

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch ${WORKDIR}/${P}-configurable.diff
	aclocal || die
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
	emake -j1 || die
}

src_install () {
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}" \
		DESTDIR=${D} install || die

	dodoc README* ChangeLog
}
