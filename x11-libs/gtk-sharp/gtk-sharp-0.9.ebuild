# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-sharp/gtk-sharp-0.9.ebuild,v 1.1 2003/05/08 13:26:59 foser Exp $

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
IUSE="gnome gnomedb"

# since mono and gtk-sharp get released together, we follow the mono version
DEPEND=">=dev-lang/mono-0.24
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	gnome? ( >=gnome-base/libgnomecanvas-2
		>=gnome-base/libgnomeui-2 )
	gnomedb? ( >=gnome-extra/libgnomedb-0.11 )"

KEYWORDS="~x86 -ppc"

src_unpack() {
	unpack ${A}

	# disable building of samples (#16015)
	cd ${S}
	mv Makefile.in Makefile.in.old
	sed -e "s:sample::" Makefile.in.old > Makefile.in
	mv configure.in configure.in.old
	sed -e "s:sample/Makefile::" -e "s:sample/rsvg/Makefile::" configure.in.old > configure.in

	# patch gst-sharp stuff
	# epatch ${FILESDIR}/${P}-gst_sharp.patch
}

src_compile() {
	# configure switches do not work

	# disable samples
	./autogen.sh

	econf || die "./configure failed"

	emake || die

	# gst-sharp hacks
	# cd ${S}/gst/
	# epatch ${FILESDIR}/${P}-generated_fix.patch
	# rm gst-sharp.dll
	# make || die "Died making gst-sharp bindings"
}

src_install () {
	# Path for the installation of the libs is hardcoded in the Makefile, 
	# so we need to change it - Is being changed, check every release
	for i in $(find . -iname Makefile); do cp $i ${i}.orig; sed "s:${DESTDIR}/usr:${D}/usr:" $i.orig > $i; done

	einstall || die

	# gst-sharp install
	# cd ${S}/gst/
	# make install || die "Gst-sharp install failed"

	dodoc HACKING README* ChangeLog
}
