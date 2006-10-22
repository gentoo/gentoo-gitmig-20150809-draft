# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-5.00-r1.ebuild,v 1.5 2006/10/22 01:06:57 omp Exp $

inherit eutils flag-o-matic pam fixheadtails autotools

IUSE="gnome jpeg insecure-savers new-login nls offensive opengl pam xinerama"

DESCRIPTION="A modular screen saver and locker for the X Window System"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"

RDEPEND="x11-libs/libXxf86misc
	x11-apps/xwininfo
	x11-apps/appres
	media-libs/netpbm
	>=sys-libs/zlib-1.1.4
	>=dev-libs/libxml2-2.5
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-1.99
	>=dev-libs/glib-2
	pam? ( virtual/pam )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl
		>=media-libs/gle-3.0.1 )
	xinerama? ( x11-libs/libXinerama )
	!arm? ( new-login? ( gnome-base/gdm ) )"

DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto
	x11-proto/scrnsaverproto
	x11-proto/recordproto
	x11-proto/xf86miscproto
	sys-devel/bc
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	xinerama? ( x11-proto/xineramaproto )"

# simple workaround for the flurry screensaver
filter-flags -mabi=altivec
filter-flags -maltivec
append-flags -U__VEC__

pkg_setup() {

	if use arm && use new-login; then
		ewarn "gnome-base/gdm is required for USE=\"new-login\", and is not"
		ewarn "available for the arm platform. please disable this use flag"
		die "new-login USE is not supported on arm"
	fi

}

src_unpack() {

	unpack "${A}"
	cd "${S}"

	# Bug fixes:
	epatch "${FILESDIR}/${P}-gentoo.patch"

	# Fix bug #143662:
	# "xscreensaver-5.00 badly parse a float resource"
	epatch "${FILESDIR}/${P}-get_float_resource.patch"

	# disable not-safe-for-work xscreensavers
	use offensive || epatch "${FILESDIR}/${P}-nsfw.patch"

	eautoreconf

	# change old head/tail to POSIX ones
	ht_fix_all

}

src_compile() {

	unset BC_ENV_ARGS
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
		--with-gtk \
		--with-xml \
		--without-kerberos \
		$(use_with insecure-savers setuid-hacks) \
		$(use_with new-login login-manager) \
		$(use_with xinerama xinerama-ext) \
		$(use_with pam) \
		$(use_with opengl gl) $(use_with opengl gle) \
		$(use_with jpeg) \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die "emake failed"

}

src_install() {

	[[ -n "${KDEDIR}" ]] && dodir "${KDEDIR}/bin"

	make install_prefix="${D}" install || die "make install failed"

	dodoc README

	# install correctly in gnome, including info about configuration preferences
	if use gnome ; then

		dodir /usr/share/gnome/capplets
		insinto /usr/share/gnome/capplets
		doins driver/screensaver-properties.desktop

		newicon "${S}/utils/images/logo-50.xpm" xscreensaver.xpm

		dodir /usr/share/control-center-2.0/capplets
		insinto /usr/share/control-center-2.0/capplets
		newins "${FILESDIR}/desktop_entries/screensaver-properties.desktop"

	fi

	# Remove "extra" capplet
	rm -f "${D}/usr/share/applications/gnome-screensaver-properties.desktop"

	use pam && fperms 755 /usr/bin/xscreensaver
	pamd_mimic_system xscreensaver auth

	# Fix bug #135549:
	rm -f "${D}/usr/share/xscreensaver/config/electricsheep.xml"
	rm -f "${D}/usr/share/xscreensaver/config/fireflies.xml"
	dodir /usr/share/man/man6x
	mv "${D}/usr/share/man/man6/worm.6" \
		"${D}/usr/share/man/man6x/worm.6x"

}

pkg_postinst() {

	if ! use new-login; then
		einfo
		einfo "You have chosen to not use the new-login USE flag."
		einfo "This is a new USE flag which enables individuals to"
		einfo "create new logins when the screensaver is active,"
		einfo "allowing others to use their account, even though the"
		einfo "screen is locked to another account. If you want this"
		einfo "feature, please recompile with USE=\"new-login\"."
		einfo
	fi

	if use insecure-savers;then
		ewarn
		ewarn "You have chosen USE=insecure-savers. While upstream"
		ewarn "has made every effort to make sure these savers do not"
		ewarn "abuse their setuid root status, the possibilty exists that"
		ewarn "someone will exploit xscreensaver and will be able to gain"
		ewarn "root privileges. You have been warned."
		ewarn
	fi

	ewarn
	ewarn "In XScreenSaver 5.00 API was changed. All third party screen savers"
	ewarn "need to be ported to the new API. Until then they will not work."
	ewarn
	epause

}
