# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-4.09.ebuild,v 1.2 2003/04/28 11:16:57 liquidx Exp $

IUSE="pam kerberos gtk motif gnome opengl jpeg xml"

DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc alpha"
SLOT="0"

# Enable gtk+ by default if 'motif' not in USE, or if
# both 'motif' and 'gtk' is in USE.  ONLY enable motif
# if 'motif', but not 'gtk' is in USE.
DEPEND="sys-devel/bc
	dev-util/pkgconfig
	gtk? ( x11-libs/gtk+
	       gnome-base/libglade
	       dev-libs/libxml2 )
	gnome? ( gnome-base/libglade
	         dev-libs/libxml2
	         gnome-base/control-center )
	motif? ( virtual/motif )
	!motif? ( x11-libs/gtk+
	          gnome-base/libglade
	          dev-libs/libxml2 )
	pam? ( sys-libs/pam )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl
	          >=media-libs/gle-3.0.1 )
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
	
	# gtk is the more stable one, so enable it by default.
	if use motif && ! use gtk
	then
		myconf="${myconf} --with-motif --without-gtk"
	else
		myconf="${myconf} --without-motif --with-gtk --with-xml"
	fi

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

	use xml2 \
		&& myconf="${myconf} --with-xml"
# Do not specifically disable xml, as gtk use it
#		|| myconf="${myconf} --without-xml"
	
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	# Check if x11-libs/gtk+-2.0 is installed
	pkg-config gtk+-2.0 &> /dev/null
	local gtk2_installed="$?"

	# Enable pixbuf support if x11-libs/gtk+-2.0 is not installed, but
	# media-libs/gdk-pixbuf is installed,
	# OR enable it if x11-libs/gtk+-2.0 is installed
	( ( [ "${gtk2_installed}" -ne 0 ] && [ -x /usr/bin/gdk-pixbuf-config ] ) \
	 || [ "${gtk2_installed}" -eq 0 ] ) \
		&& myconf="${myconf} --with-pixbuf"
	
	# Enable gnome support (control-center capplet) if 'gnome' in USE,
	# but gtk+-2.0 is not installed.
	( [ "${gtk2_installed}" -ne 0 ] && use gnome ) \
		&& myconf="${myconf} --with-gnome"

	export C_INCLUDE_PATH="/usr/include/libxml2/"
	econf \
		--enable-hackdir=/usr/lib/xscreensaver \
		--x-libraries=/usr/X11R6/lib \
		--x-includes=/usr/X11R6/include \
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
	[ -n "${KDEDIR}" ] && dodir ${KDEDIR}/bin
	
	make install_prefix="${D}" install || die
	
	# install correctly in gnome2 
	use gnome && ( \
		dodir /usr/share/gnome/capplets
		insinto /usr/share/gnome/capplets
		doins driver/screensaver-properties.desktop
	)

	# Remove "extra" capplet
	rm -f ${D}/usr/share/control-center/capplets/screensaver-properties.desktop

	use gnome && ( \
		insinto /usr/share/pixmaps
		newins ${S}/utils/images/logo-50.xpm xscreensaver.xpm
	)

	use pam && ( \
		insinto /etc/pam.d
		doins ${FILESDIR}/pam.d/xscreensaver
	)
}
