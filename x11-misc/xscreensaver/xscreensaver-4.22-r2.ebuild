# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-4.22-r2.ebuild,v 1.10 2005/08/23 21:47:19 agriffis Exp $

inherit eutils flag-o-matic pam

IUSE="gnome gtk jpeg kde kerberos krb4 motif new-login nls offensive opengl pam xinerama"

DESCRIPTION="A modular screen saver and locker for the X Window System"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

LICENSE="BSD"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~sparc x86"
SLOT="0"

# NOTE: ignore app-games/fortune-mod as a dep. it is pluggable and won't
#       really matter if it isn't there. Maybe we should have a 'games'
#       USE flag

RDEPEND="virtual/x11
	media-libs/netpbm
	>=sys-libs/zlib-1.1.4
	gtk? (
		>=dev-libs/libxml2-2.5
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-1.99
		>=dev-libs/glib-2
	)
	motif? ( x11-libs/openmotif )
	pam? ( virtual/pam )
	kerberos? ( krb4? ( >=app-crypt/mit-krb5-1.2.5 ) )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl
	          >=media-libs/gle-3.0.1 )
	!arm? ( new-login? ( gnome-base/gdm ) )"

DEPEND="${RDEPEND}
	sys-devel/bc
	dev-lang/perl
	gtk? ( dev-util/pkgconfig )
	nls? ( sys-devel/gettext )"

# simple workaround for the flurry screensaver
filter-flags -mabi=altivec
filter-flags -maltivec
append-flags -U__VEC__

pkg_setup() {
	if ! use gtk ; then
		if use motif ; then
			ewarn "From the configure script:"
			ewarn
			ewarn "  Though the Motif front-end to xscreensaver is still"
			ewarn "  maintained, it is no longer being updated with new"
			ewarn "  features: all new development on the xscreensaver-demo"
			ewarn "  program is happening in the GTK version, and not in the"
			ewarn "  Motif version."
			ewarn
			ewarn "It is recommended that you use the \"gtk\" USE flag."
		else
			ewarn "You have enabled neither gtk nor motif USE flags.  xscreensaver-demo"
			ewarn "requires either GTK+ 2 or Motif (GTK+ 2 is recommended, as the Motif"
			ewarn "version is no longer being maintained), so xscreensaver-demo will not"
			ewarn "be built.  This is most likely NOT what you want."
		fi
		ewarn
		epause
	fi
	if use kerberos && ! use krb4 ; then
		ewarn "You have enabled kerberos without krb4 support. Kerberos will be"
		ewarn "disabled unless kerberos 4 support has been compiled with your"
		ewarn "kerberos libraries. To do that, you should abort now and do:"
		ewarn
		ewarn " USE=\"krb4\" emerge mit-krb5"
		ewarn
		epause
	fi
	if use arm && use new-login; then
		ewarn "gnome-base/gdm is required for USE=\"new-login\", and is not"
		ewarn "available for the arm platform. please disable this use flag"
		die "new-login USE is not supported on arm"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# disable rpm -q checking, otherwise it breaks sandbox if rpm is installed
	# use gnome-terminal in tests rather than gnome-open (bug #94708)
	epatch ${FILESDIR}/${PN}-4.22-configure.patch
	# tweaks the default configuration (driver/XScreenSaver.ad.in)
	epatch ${FILESDIR}/${PN}-4.22-settings.patch
	# fixes wrong argument for inter-aggregate screensaver
	epatch ${FILESDIR}/${PN}-4.22-interaggregate.patch
	# disable not-safe-for-work xscreensavers
	use offensive || epatch ${FILESDIR}/${PN}-4.16-nsfw.patch
}

src_compile() {
	local myconf

	if use gtk ; then
		myconf="${myconf} --without-motif --with-xml"
	elif use motif; then
		myconf="${myconf} --with-motif --without-pixbuf"
	else
		myconf="${myconf} --without-motif --without-pixbuf"
	fi

	use kerberos && use krb4 \
		&& myconf="${myconf} --with-kerberos" \
		|| myconf="${myconf} --without-kerberos"

	econf \
		--with-hackdir=/usr/lib/misc/xscreensaver \
		--with-configdir=/usr/share/xscreensaver/config \
		--x-libraries=/usr/$(get_libdir) \
		--x-includes=/usr/include \
		--with-mit-ext \
		--with-dpms-ext \
		--with-xf86vmode-ext \
		--with-xf86gamma-ext \
		--with-proc-interrupts \
		--with-xpm \
		--with-xshm-ext \
		--with-xdbe-ext \
		--enable-locking \
		$(use_with gtk) \
		$(use_with new-login login-manager) \
		$(use_with xinerama xinerama-ext) \
		$(use_with pam) \
		$(use_with opengl gl) $(use_with opengl gle) \
		$(use_with jpeg) \
		$(use_enable nls) \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	[ -n "${KDEDIR}" ] && dodir ${KDEDIR}/bin

	make install_prefix="${D}" install || die "make install failed"

	dodoc README

	# install correctly in gnome2
	if use gnome ; then
		dodir /usr/share/gnome/capplets
		insinto /usr/share/gnome/capplets
		doins driver/screensaver-properties.desktop
	fi

	# install symlink to satisfy kde
	use kde && dosym /usr/share/xscreensaver/config /usr/$(get_libdir)/xscreensaver/config

	# Remove "extra" capplet
	rm -f ${D}/usr/share/applications/gnome-screensaver-properties.desktop

	if use gnome ; then
		insinto /usr/share/pixmaps
		newins ${S}/utils/images/logo-50.xpm xscreensaver.xpm
	fi

	use pam && fperms 755 /usr/bin/xscreensaver
	pamd_mimic_system xscreensaver auth
}

pkg_postinst() {
	if ! use new-login; then
		einfo "You have chosen to not use the new-login USE flag."
		einfo "This is a new USE flag which enables individuals to"
		einfo "create new logins when the screensaver is active,"
		einfo "allowing others to use their account, even though the"
		einfo "screen is locked to another account. If you want this"
		einfo "feature, please recompile with USE=\"new-login\"."
	fi
}
