# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gtk-sharp/gtk-sharp-0.7-r1.ebuild,v 1.2 2003/02/20 17:00:00 foser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL"
SLOT="0"
IUSE="gnome"

DEPEND=">=dev-lang/mono-0.16
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	gnome? ( >=gnome-base/libgnomecanvas-2
		>=gnome-base/libgnomeui-2 )"

KEYWORDS="~x86 -ppc"

src_unpack() {
	unpack ${A}

	# disable building of samples (#16015)
	cd ${S}
	mv makefile makefile.old
	sed -e "s:sample::" makefile.old > makefile
	mv configure.in configure.in.old
	sed -e "s:sample/Makefile::" configure.in.old > configure.in
}

src_compile() {
	local myconf
	myconf="--enable-glade"

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"

	# disable samples
	./autogen.sh

	econf ${myconf} || die "./configure failed"

	# mcs wants this during build
	addwrite ~/.wapi
	emake || die
}

src_install () {
	# Path for the installation of the libs is hardcoded in the Makefile, 
	# so we need to change it - Is being changed, check evry release
	for i in $(find . -iname Makefile); do cp $i ${i}.orig; sed "s:${DESTDIR}/usr:${D}/usr:" $i.orig > $i; done

	einstall || die
	dodoc HACKING README* ChangeLog
}
