# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-sharp/gtk-sharp-0.15.ebuild,v 1.1 2004/02/02 07:00:15 tberman Exp $

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

RDEPEND=">=dev-dotnet/mono-0.24
	>=x11-libs/gtk+-2.2
	>=gnome-base/libglade-2
	gnome? ( >=gnome-base/libgnomecanvas-2.2
		>=gnome-base/libgnomeui-2.2 )
	libgda? ( >=gnome-extra/libgda-0.11 )
	gnomedb? ( >=gnome-extra/libgnomedb-0.11 )
	gtkhtml? ( >=gnome-extra/libgtkhtml-3* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KEYWORDS="~x86 -ppc"

src_unpack() {
	unpack ${A}

	# disable building of samples (#16015)
	cd ${S}
	mv Makefile.in Makefile.in.old
	sed -e "s:sample::" Makefile.in.old > Makefile.in

	# patch gst-sharp stuff
	# epatch ${FILESDIR}/${P}-gst_sharp.patch
}

src_compile() {

	econf || die "./configure failed"

	MAKEOPTS="-j1" MONO_PATH=${S} emake || die

	# gst-sharp hacks
	# cd ${S}/gst/
	# epatch ${FILESDIR}/${P}-generated_fix.patch
	# rm gst-sharp.dll
	# make || die "Died making gst-sharp bindings"
}

src_install () {
	# Path for the installation of the libs is hardcoded in the Makefile,
	# so we need to change it - Is being changed, check every release
	for i in $(find . -iname Makefile); do cp $i ${i}.orig; sed -e "s:${DESTDIR}/usr:${D}/usr:" -e "s:${D}/usr/bin:${DESTDIR}/usr/bin:" < $i.orig > $i; done

	# one of the samples require gconf schemas, and it'll violate sandbox
	GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1" einstall || die

	# gst-sharp install
	# cd ${S}/gst/
	# make install || die "Gst-sharp install failed"

	dodoc HACKING README* ChangeLog
}
