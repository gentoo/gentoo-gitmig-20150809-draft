# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-sharp/gtk-sharp-0.91.1.ebuild,v 1.1 2004/05/05 04:54:19 latexer Exp $

# WARNING
# All gst-sharp hacks done in this build are nonfunctional
# Do not try to use them, they don't work. Not for me, not for anybody.
# They're just here for future reference
#
# foser <foser@gentoo.org>

inherit eutils mono

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="gnome gnomedb libgda gtkhtml"

RDEPEND=">=sys-apps/sed-4.0
	>=dev-dotnet/mono-0.91
	>=x11-libs/gtk+-2.2
	>=gnome-base/libglade-2
	>=gnome-base/ORBit2-2.8.3
	gnome? ( >=gnome-base/libgnomecanvas-2.2
		>=gnome-base/libgnomeui-2.2
		>=gnome-base/libgnomeprintui-2.2 )
	libgda? ( >=gnome-extra/libgda-0.11 )
	gnomedb? ( >=gnome-extra/libgnomedb-0.11 )
	gtkhtml? ( >=gnome-extra/libgtkhtml-3.0.10 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KEYWORDS="~x86 -ppc"

src_unpack() {
	unpack ${A}

	# disable building of samples (#16015)
	cd ${S}
	sed -i -e "s:sample::" -e "s:doc::" Makefile.in
}

src_compile() {
	econf || die "./configure failed"

	MAKEOPTS="-j1" MONO_PATH=${S} emake || die
}

src_install () {
	# one of the samples require gconf schemas, and it'll violate sandbox
	GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1" einstall || die

	# gst-sharp install
	# cd ${S}/gst/
	# make install || die "Gst-sharp install failed"

	dodoc README* ChangeLog
}
