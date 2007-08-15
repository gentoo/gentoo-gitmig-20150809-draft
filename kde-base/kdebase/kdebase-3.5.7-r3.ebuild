# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.5.7-r3.ebuild,v 1.10 2007/08/15 04:49:46 jer Exp $

inherit kde-dist eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-06.tar.bz2"

DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="branding cups java ldap ieee1394 hal lm_sensors logitech-mouse openexr opengl
pam samba xcomposite xscreensaver xinerama kdehiddenvisibility"

# hal: enables hal backend for 'media:' ioslave

DEPEND=">=media-libs/freetype-2
	media-libs/fontconfig
	dev-libs/openssl
	pam? ( kde-base/kdebase-pam )
	>=dev-libs/cyrus-sasl-2
	ldap? ( >=net-nds/openldap-2 )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	samba? ( >=net-fs/samba-3.0.4 )
	lm_sensors? ( sys-apps/lm_sensors )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )
	ieee1394? ( sys-libs/libraw1394 )
	hal? ( dev-libs/dbus-qt3-old =sys-apps/hal-0.5* )
	xcomposite? ( x11-libs/libXcomposite x11-libs/libXdamage )
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXext
	xscreensaver? ( x11-libs/libXScrnSaver )
	xinerama? ( x11-libs/libXinerama )"

RDEPEND="${DEPEND}
	sys-apps/usbutils
	sys-devel/gdb
	java? ( >=virtual/jre-1.4 )
	kernel_linux? ( || ( >=sys-apps/eject-2.1.5 sys-block/unieject ) )
	virtual/ssh
	www-misc/htdig
	x11-apps/mkfontdir
	x11-apps/setxkbmap
	x11-apps/xinit
	|| ( x11-misc/xkeyboard-config x11-misc/xkbdata )
	x11-apps/xmessage
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xsetroot
	x11-apps/xset"

DEPEND="${DEPEND}
	xcomposite? ( x11-proto/compositeproto x11-proto/damageproto )
	xscreensaver? ( x11-proto/scrnsaverproto )
	xinerama? ( x11-proto/xineramaproto )
	x11-apps/bdftopcf
	x11-apps/xhost"

need-kde 3.5.7

pkg_setup() {
	kde_pkg_setup
	if use hal && has_version '<sys-apps/dbus-0.90' && ! built_with_use sys-apps/dbus qt3; then
		eerror "To enable HAL support in this package is required to have"
		eerror "sys-apps/dbus compiled with Qt 3 support."
		eerror "Please reemerge sys-apps/dbus with USE=\"qt3\"."
		die "Please reemerge sys-apps/dbus with USE=\"qt3\"."
	fi
}

src_unpack() {
	kde_src_unpack

	# Avoid using imake (kde bug 114466).
	#epatch "${WORKDIR}/patches/kdebase-3.5.0_beta2-noimake.patch"
	# ...included in patch set
	rm -f "${S}/configure"

	# FIXME - disable broken tests
	sed -i -e "s:TESTS =.*:TESTS =:" ${S}/kioslave/smtp/Makefile.am || die "sed failed"
	sed -i -e "s:TESTS =.*:TESTS =:" ${S}/kioslave/trash/Makefile.am || die "sed failed"
	sed -i -e "s:SUBDIRS = viewer test:SUBDIRS = viewer:" ${S}/nsplugins/Makefile.am || die "sed failed"

	if ! [[ $(xhost >> /dev/null 2>/dev/null) ]] ; then
		einfo "User ${USER} has no X access, disabling some tests."
		for ioslave in media remote home system ; do
			sed -e "s:check\: test${ioslave}::" -e "s:./test${ioslave}::" \
				-i kioslave/${ioslave}/Makefile.am || die "sed failed"
		done
	fi
}

src_compile() {
	local myconf="--with-dpms --enable-dnssd --with-sssl
					--with-usbids=/usr/share/misc/usb.ids
					$(use_with ieee1394 libraw1394)
					$(use_with hal)
					$(use_with ldap)
					$(use_with lm_sensors sensors)
					$(use_with logitech-mouse libusb)
					$(use_with openexr)
					$(use_with opengl gl)
					$(use_with pam)
					$(use_with samba)
					$(use_with xcomposite composite)
					$(use_with xinerama)
					$(use_with xscreensaver)"

	if ! use pam && use elibc_glibc; then
		myconf="${myconf} --with-shadow"
	fi

	# the java test is problematic (see kde bug 100729) and
	# useless. All that's needed for java applets to work is
	# to have the 'java' executable in PATH.
	myconf="${myconf} --without-java"

	export BINDNOW_FLAGS="$(bindnow-flags)"

	kde_src_compile
}

src_install() {
	kde_src_install
	cd ${S}/kdm && make DESTDIR=${D} GENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice" install

	# startup and shutdown scripts
	insinto ${KDEDIR}/env
	doins "${WORKDIR}/patches/agent-startup.sh"

	exeinto ${KDEDIR}/shutdown
	doexe "${WORKDIR}/patches/agent-shutdown.sh"

	# freedesktop environment variables
	cat <<EOF > "${T}/xdg.sh"
export XDG_CONFIG_DIRS="${KDEDIR}/etc/xdg"
EOF
	insinto "${KDEDIR}/env"
	doins "${T}/xdg.sh"

	# x11 session script
	cat <<EOF > "${T}/kde-${SLOT}"
#!/bin/sh
exec ${KDEDIR}/bin/startkde
EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/kde-${SLOT}"

	# freedesktop compliant session script
	sed -e "s:@KDE_BINDIR@:${KDEDIR}/bin:g;s:Name=KDE:Name=KDE ${SLOT}:" \
		"${S}/kdm/kfrontend/sessions/kde.desktop.in" > "${T}/kde-${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/kde-${SLOT}.desktop"

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		"${D}/${KDEDIR}/share/config/kdm/kdmrc" || die

	rmdir "${D}/${KDEDIR}/share/templates/.source/emptydir"

	if use branding ; then
		dodir ${PREFIX}/share/services/searchproviders
		insinto ${PREFIX}/share/services/searchproviders
		doins ${WORKDIR}/patches/*.desktop
	fi
}

pkg_preinst() {
	kde_pkg_preinst

	# We need to symlink here, as kfmclient freaks out completely,
	# if it does not find konqueror.desktop in the legacy path.
	dodir ${PREFIX}/share/applications/kde
	dosym ../../applnk/konqueror.desktop ${PREFIX}/share/applications/kde/konqueror.desktop
}

pkg_postinst() {
	kde_pkg_postinst

	# set the default kdm face icon if it's not already set by the system admin
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/root1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/root.face.icon"
	fi

	mkdir -p "${ROOT}${KDEDIR}/share/templates/.source/emptydir"

	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${KDEDIR}/env/agent-startup.sh and"
	elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
	if use branding ; then
		elog "We've added three Gentoo-related web shortcuts to Konqueror:"
		elog "- gb           Gentoo Bugzilla searching"
		elog "- gf           Gentoo Forums searching"
		elog "- gp           Gentoo Package searching"
		echo
		elog "You'll have to activate them in 'Configure Konqueror...'."
		echo
		elog "If you can't open new konqueror windows and get something like"
		elog "'WARNING: Outdated database found' when starting konqueror in a console, run"
		elog "kbuildsycoca as the user you're running KDE under."
		elog "This is NOT a bug."
		echo
	fi
}
