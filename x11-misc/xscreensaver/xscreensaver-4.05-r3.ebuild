# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-4.05-r3.ebuild,v 1.12 2003/04/15 11:38:09 liquidx Exp $

IUSE="pam gtk motif gnome opengl"

DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"
LICENSE="BSD"
KEYWORDS="x86 sparc  ppc"
SLOT="0"

DEPEND="virtual/x11 sys-devel/bc
	gtk? ( x11-libs/gtk+ )
	motif? ( virtual/motif )
	opengl? ( virtual/opengl >=media-libs/gle-3.0.1 )
	gnome? ( media-libs/gdk-pixbuf
		>=gnome-base/control-center-1.4.0.1-r1 )
	pam? ( >=sys-libs/pam-0.75 )
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	media-libs/netpbm"

src_unpack() {

	unpack ${A}
	cd ${S}

	#use nls && ( \
	#	cd po
	#	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
	#) || ( \
		cp Makefile.in Makefile.in.orig
		sed "s:hacks/glx po:hacks/glx:" \
			Makefile.in.orig > Makefile.in
	#)
}

src_compile() {
	local myconf=""
	use gnome \
		&& myconf="${myconf} --with-gnome" \
		|| myconf="${myconf} --without-gnome"

	use gtk \
		&& myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --without-gtk"

	use motif \
		&& myconf="${myconf} --with-motif" \
		|| myconf="${myconf} --without-motif"

	use pam \
		&& myconf="${myconf} --with-pam" \
		|| myconf="${myconf} --without-pam"

	use opengl \
		&& myconf="${myconf} --with-gl --with-gle" \
		|| myconf="${myconf} --without-gl --without-gle"

	export C_INCLUDE_PATH="/usr/include/libxml2/libxml/"
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host="${CHOST}" \
		--x-libraries=/usr/X11R6/lib \
		--x-includes=/usr/X11R6/includes \
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
	# install correctly in gnome2 
	use gnome && ( \
		dodir /usr/share/gnome/capplets
		insinto /usr/share/gnome/capplets
		doins "driver/screensaver-properties.desktop"
	)

	use gnome && ( \
		insinto /usr/share/pixmaps
		newins ${S}/utils/images/logo-50.xpm xscreensaver.xpm
	)

	use pam && ( \
		insinto /etc/pam.d
		doins "${FILESDIR}/pam.d/xscreensaver"
	)
}
