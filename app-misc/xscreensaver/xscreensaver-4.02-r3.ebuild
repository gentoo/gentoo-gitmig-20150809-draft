# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Martin Schlemmer <azarah@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/xscreensaver/xscreensaver-4.02-r3.ebuild,v 1.1 2002/06/02 09:05:26 azarah Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

RDEPEND="virtual/x11
	jpeg? ( media-libs/jpeg )
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	opengl? ( virtual/opengl >=media-libs/gle-3.0.1 )
	gnome? ( >=gnome-base/control-center-1.4.0.1-r1 )
	pam? ( >=sys-libs/pam-0.75 )
	dev-libs/libxml2"

DEPEND="${RDEPEND}
	sys-devel/bc"

src_compile() {

	local myconf=""
	use jpeg && myconf="${myconf} --with-jpeg"
	use jpeg || myconf="${myconf} --without-jpeg"
	use gnome && myconf="${myconf} --with-gnome --with-pixbuf"
	use gnome || myconf="${myconf} --without-gnome"
	use gtk && 	myconf="${myconf} --with-gtk"
	use gtk || myconf="${myconf} --without-gtk"
	use motif && myconf="${myconf} --with-motif"
	use motif || myconf="${myconf} --without-motif"
	use pam && myconf="${myconf} --with-pam"
	use pam || myconf="${myconf} --without-pam"
	use opengl && myconf="${myconf} --with-gl --with-gle"
	use opengl || myconf="${myconf} --without-gl --without-gle"
	
	export C_INCLUDE_PATH="/usr/include/libxml2/libxml/"
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--enable-hackdir=/usr/lib/xscreensaver \
		--with-mit-ext \
		--with-dpms-ext \
		--with-xinerama-ext \
		--with-xf86vmode-ext \
		--with-xf86gamma-ext \
		--with-proc-interrupts \
		--with-xpm \
		--with-xshm-ext \
		--with-xdbe-ext \
		--enable-locking \
		${myconf} || die
		
	emake || die
	unset C_INCLUDE_PATH
}

src_install() {

	[ -n "${KDEDIR}" ] && dodir ${KDEDIR}/bin

	make install_prefix=${D} install || die

	# Fix double Control Center entry
	rm -f "${D}/usr/share/control-center/capplets/screensaver.desktop"

	if [ "`use pam`" ]
	then
		insinto /etc/pam.d
		doins "${FILESDIR}/pam.d/xscreensaver"
	fi
	
	[ -n "`use kde`" ] || ( [ -n "${KDEDIR}" ] && rm -rf ${D}/${KDEDIR} )
}

