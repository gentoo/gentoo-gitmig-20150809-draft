# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Martin Schlemmer <azarah@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/app-misc/xscreensaver/xscreensaver-4.02.ebuild,v 1.3 2002/05/23 06:50:09 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

DEPEND="virtual/x11 sys-devel/bc
	gtk? ( =x11-libs/gtk+-1.2* )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	opengl? ( virtual/opengl >=media-libs/gle-3.0.1 )
	gnome? ( >=gnome-base/control-center-1.4.0.1-r1 )
	pam? ( >=sys-libs/pam-0.75 )"

RDEPEND="virtual/x11
	gtk? ( =x11-libs/gtk+-1.2* )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	opengl? ( virtual/opengl >=media-libs/gle-3.0.1 )
	gnome? ( >=gnome-base/control-center-1.4.0.1-r1 )
	pam? ( >=sys-libs/pam-0.75 )"

src_compile() {
	local myconf=""
	if [ "`use gnome`" ]
	then
		myconf="${myconf} --with-gnome"
	else
		myconf="${myconf} --without-gnome"
	fi
	if [ "`use gtk`" ]
	then
		myconf="${myconf} --with-gtk"
	else
		myconf="${myconf} --without-gtk"
	fi
	if [ "`use motif`" ]
	then
		myconf="${myconf} --with-motif"
	else
		myconf="${myconf} --without-motif"
	fi
	if [ "`use pam`" ]
	then
		myconf="${myconf} --with-pam"
	else
		myconf="${myconf} --without-pam"
	fi
	if [ "`use opengl`" ]
	then
		myconf="${myconf} --with-gl --with-gle"
	else
		myconf="${myconf} --without-gl --without-gle"
	fi

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host="${CHOST}" \
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
}

src_install() {

	[ -n "$KDEDIR" ] && dodir "$KDEDIR/bin"
	
	make install_prefix="${D}" install || die

	# Fix double Control Center entry
	rm -f "${D}/usr/share/control-center/capplets/screensaver.desktop"

	if [ "`use pam`" ]
	then
		insinto /etc/pam.d
		doins "${FILESDIR}/pam.d/xscreensaver"
	fi
	
	[ -n "`use kde`" ] || rm -rf ${D}/${KDEDIR}
	
}

