# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-4.06.ebuild,v 1.2 2002/10/24 17:26:10 azarah Exp $

IUSE="pam kerberos gtk motif gnome opengl jpeg xml"

DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"
SLOT="0"

DEPEND="sys-devel/bc
	gtk? ( x11-libs/gtk+ )
	pam? ( sys-libs/pam )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl
		>=media-libs/gle-3.0.1 )
	gnome? ( media-libs/gdk-pixbuf
		gnome-base/control-center )
	xml? ( dev-libs/libxml2 )"

RDEPEND="${DEPEND}
	media-libs/netpbm"

src_unpack() {

	unpack ${A}
	cd ${S}

	cp Makefile.in Makefile.in.orig
	sed "s:hacks/glx po:hacks/glx:" \
		Makefile.in.orig > Makefile.in
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

	use kerberos \
		&& myconf="${myconf} --with-kerberos" \
		|| myconf="${myconf} --without-kerberos"

	use opengl \
		&& myconf="${myconf} --with-gl --with-gle" \
		|| myconf="${myconf} --without-gl --without-gle"

	use jpeg \
		&& myconf="${myconf} --with-jpeg" \
		|| myconf="${myconf} --without-jpeg"

	use xml \
		&& myconf="${myconf} --with-xml" \
		|| myconf="${myconf} --without-xml"
	
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	export C_INCLUDE_PATH="/usr/include/libxml2/"
	econf \
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
