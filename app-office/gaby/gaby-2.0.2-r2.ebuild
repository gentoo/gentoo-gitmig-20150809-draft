# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gaby/gaby-2.0.2-r2.ebuild,v 1.5 2003/09/06 22:21:01 msterret Exp $

inherit eutils

DESCRIPTION="A small personal databases manager for Linux"
HOMEPAGE="http://gaby.theridion.com/"
SRC_URI="http://gaby.theridion.com/archives/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls esd gnome"

DEPEND=">=sys-apps/portage-2.0.47-r10
	virtual/python
	dev-libs/libxml
	<dev-python/gnome-python-1.99
	=x11-libs/gtk+-1.2*
	=gnome-base/libglade-0.17*
	>=media-libs/gdk-pixbuf-0.11.0-r1
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	esd? ( >=media-sound/esound-0.2.8 )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	#patches a few makefile bugs
	#some necessary, others not because multimedia is disabled
	epatch ${FILESDIR}/gaby-2.0.2-makefile.patch
}

src_compile() {
	local myopts="`use_enable gnome`"

	if [ -z "`use nls`" ]
	then
		myopts="${myopts} --disable-nls"
	fi

	cp ${FILESDIR}/Makefile.in intl/Makefile.in

	cp configure configure.orig
	sed -e "7293 c\ if test -f /usr/include/pygtk/pygtk.h; then" \
	< configure.orig > configure

	#disable multimedia for now, saves me a lot of patching
	./configure 	\
		--host=${CHOST}	\
		${myopts}	\
		--disable-multimedia \
		--prefix=/usr 	\
		--datadir=/usr/share || die

	cd src
	cp Makefile Makefile.orig
	sed -e "s:install-exec-local::" \
		-e "s:^\::gentoo change\::" Makefile.orig > Makefile

	#Fix localization files sandbox issue
	cd ${S}/po
	cp Makefile Makefile.orig
	sed -e "s:prefix = /usr:prefix = \${DESTDIR}/usr:" Makefile.orig > Makefile

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosym gaby ${prefix}/bin/gbc
	dosym gaby ${prefix}/bin/gcd
	dosym gaby ${prefix}/bin/videobase
	dosym gaby ${prefix}/bin/gnomecard
	dosym gaby ${prefix}/bin/appindex

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS
	dodoc README TODO TODO.more

	insinto ${prefix}/share/pixmaps
	insopt -m 0644
	doins gnome-gaby-builder.png gnome-gaby.png

}
