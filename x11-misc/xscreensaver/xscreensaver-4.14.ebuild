# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-4.14.ebuild,v 1.4 2004/01/11 13:53:15 lanius Exp $

IUSE="pam kerberos krb4 gtk gtk2 gnome opengl jpeg xinerama"

DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~amd64"
SLOT="0"

# NOTE: the motif interface is not supported/developed anymore
#       by xscreensaver devs. so we should deprecate it soon
# FIXME: xscreensaver does it's own detection of gtk2 and uses gtk2
#        automatically over gtk1. we need to patch the autoconf stuff
#        to correctly allow users to choose gtk1/gtk2. right now it
#        only selects the deps.
# NOTE: ignore app-games/fortune-mod as a dep. it is pluggable and won't
#       really matter if it isn't there. Maybe we should have a 'games'
#       USE flag

RDEPEND="virtual/x11
	media-libs/netpbm
	>=sys-libs/zlib-1.1.4
	gtk? ( >=dev-libs/libxml2-2.5 )
	gtk? ( gtk2? ( >=x11-libs/gtk+-2
					>=gnome-base/libglade-1.99
					>=dev-libs/glib-2 ) )
	gtk? ( gtk2? ( gnome? ( >=gnome-extra/yelp-2 ) ) )
	gtk? ( !gtk2? ( =x11-libs/gtk+-1.2*
					=gnome-base/libglade-0.17* ) )
	gtk? ( !gtk2? ( gnome? ( =gnome-base/control-center-1.4*
							>=media-libs/gdk-pixbuf-0.18
							>=gnome-base/gnome-libs-1.4 ) ) )
	!gtk? ( x11-libs/openmotif )
	pam? ( sys-libs/pam )
	kerberos? ( krb4? ( >=app-crypt/mit-krb5-1.2.5 ) )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl
	          >=media-libs/gle-3.0.1 )"

DEPEND="${RDEPEND}
	sys-devel/bc
	dev-lang/perl
	gtk2? ( dev-util/pkgconfig )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	if [ -n "`use kerberos`" -a -z "`use krb4`" ]; then
		ewarn "You have enabled kerberos without krb4 support. Kerberos will be"
		ewarn "disabled unless kerberos 4 support has been compiled with your"
		ewarn "kerberos libraries. To do that, you should abort now and do:"
		ewarn ""
		ewarn " USE=\"krb4\" emerge mit-krb5"
		ewarn
		sleep 2
	fi
}

src_unpack() {
	unpack ${A}

	# disable rpm -q checking, otherwise it breaks sandbox if rpm is installed
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/xscreensaver-4.10-norpm.patch
}

src_compile() {
	local myconf=""

	myconf="--with-fortune=/usr/bin/fortune"

	use gtk \
		&& myconf="${myconf} --without-motif --with-gtk --with-xml" \
		|| myconf="${myconf} --with-motif --without-gtk --without-gdk-pixbuf"

	use xinerama \
		&& myconf="${myconf} --with-xinerama-ext" \
		|| myconf="${myconf} --without-xinerama-ext"

	use pam \
		&& myconf="${myconf} --with-pam" \
		|| myconf="${myconf} --without-pam"

	use kerberos && use krb4 \
		&& myconf="${myconf} --with-kerberos" \
		|| myconf="${myconf} --without-kerberos"

	use opengl \
		&& myconf="${myconf} --with-gl --with-gle" \
		|| myconf="${myconf} --without-gl --without-gle"

	use jpeg \
		&& myconf="${myconf} --with-jpeg" \
		|| myconf="${myconf} --without-jpeg"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	if [ -z "`use gtk2`" -a -n "`use gtk`" ]; then
		if [ -n "`use gnome`" ]; then
			myconf="${myconf} --with-gnome --with-pixbuf"
		fi
	fi

	#export C_INCLUDE_PATH="/usr/include/libxml2/"
	econf \
		--enable-hackdir=/usr/lib/xscreensaver \
		--x-libraries=/usr/X11R6/lib \
		--x-includes=/usr/X11R6/include \
		--with-mit-ext \
		--with-dpms-ext \
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

	# install symlink to satisfy kde
	use kde && dosym /usr/share/control-center/screensavers /usr/lib/xscreensaver/config

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
