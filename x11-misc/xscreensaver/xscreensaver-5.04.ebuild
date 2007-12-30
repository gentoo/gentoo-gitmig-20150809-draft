# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-5.04.ebuild,v 1.1 2007/12/30 19:39:31 drac Exp $

inherit eutils flag-o-matic pam fixheadtails autotools

DESCRIPTION="A modular screen saver and locker for the X Window System"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"
HOMEPAGE="http://www.jwz.org/xscreensaver"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="jpeg new-login offensive opengl pam suid xinerama"

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
	opengl? ( virtual/opengl )
	xinerama? ( x11-libs/libXinerama )
	new-login? ( gnome-base/gdm )"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto
	x11-proto/scrnsaverproto
	x11-proto/recordproto
	x11-proto/xf86miscproto
	sys-devel/bc
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	xinerama? ( x11-proto/xineramaproto )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-5.02-gentoo.patch

	# Update spec. using desktop-file-validate.
	epatch "${FILESDIR}"/${P}-desktop-entry.patch

	# disable offensive screensavers.
	use offensive || epatch "${FILESDIR}"/${P}-nsfw.patch

	eautoreconf

	# change head and tail calls to POSIX ones.
	ht_fix_all
}

src_compile() {
	# simple workaround for the flurry screensaver
	filter-flags -mabi=altivec
	filter-flags -maltivec
	append-flags -U__VEC__

	unset BC_ENV_ARGS
	econf \
		--with-x-app-defaults=/usr/share/X11/app-defaults \
		--with-hackdir=/usr/lib/misc/xscreensaver \
		--with-configdir=/usr/share/xscreensaver/config \
		--x-libraries=/usr/$(get_libdir) \
		--x-includes=/usr/include \
		--with-dpms-ext \
		--with-xf86vmode-ext \
		--with-xf86gamma-ext \
		--with-proc-interrupts \
		--with-xpm \
		--with-xshm-ext \
		--with-xdbe-ext \
		--enable-locking \
		--with-gtk \
		--without-kerberos \
		--without-gle \
		$(use_with suid setuid-hacks) \
		$(use_with new-login login-manager) \
		$(use_with xinerama xinerama-ext) \
		$(use_with pam) \
		$(use_with opengl gl) \
		$(use_with jpeg)

	# Fix bug 155049.
	emake -j1 || die "emake failed."
}

src_install() {
	emake install_prefix="${D}" install || die "emake install failed."

	dodoc README*

	use pam && fperms 755 /usr/bin/xscreensaver
	pamd_mimic_system xscreensaver auth

	# Fix bug #135549.
	rm -f "${D}"/usr/share/xscreensaver/config/electricsheep.xml
	rm -f "${D}"/usr/share/xscreensaver/config/fireflies.xml
	dodir /usr/share/man/man6x
	mv "${D}"/usr/share/man/man6/worm.6 \
		"${D}"/usr/share/man/man6x/worm.6x
}

pkg_postinst() {
	if ! use new-login; then
		elog
		elog "You have chosen to not use the new-login USE flag."
		elog "This is a new USE flag which enables individuals to"
		elog "create new logins when the screensaver is active,"
		elog "allowing others to use their account, even though the"
		elog "screen is locked to another account. If you want this"
		elog "feature, please recompile with USE=\"new-login\"."
		elog
	fi
}
