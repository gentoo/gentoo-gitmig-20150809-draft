# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.5.2-r1.ebuild,v 1.1 2006/04/17 18:36:53 carlo Exp $

inherit kde-dist eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5.0-patches-1.tar.bz2
	mirror://gentoo/kdebase-3.5.2-patchset.tar.bz2"

DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="arts cups java ldap ieee1394 hal lm_sensors logitech-mouse openexr opengl
pam samba ssl zeroconf xcomposite xscreensaver xinerama"
# hal: enables hal backend for 'media:' ioslave

DEPEND="arts? ( ~kde-base/arts-${PV} )
	>=media-libs/freetype-2
	media-libs/fontconfig
	pam? ( kde-base/kdebase-pam )
	>=dev-libs/cyrus-sasl-2
	ldap? ( >=net-nds/openldap-2 )
	cups? ( net-print/cups )
	ssl? ( dev-libs/openssl )
	opengl? ( virtual/opengl )
	openexr? ( >=media-libs/openexr-1.2 )
	samba? ( >=net-fs/samba-3.0.4 )
	lm_sensors? ( sys-apps/lm_sensors )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )
	ieee1394? ( sys-libs/libraw1394 )
	hal? ( >=sys-apps/dbus-0.33
	       =sys-apps/hal-0.5*
		   sys-apps/pmount )
	zeroconf? ( net-misc/mDNSResponder )
	xcomposite? ( || ( (
			x11-libs/libXcomposite
			x11-libs/libXdamage
			) <=x11-base/xorg-x11-6.9 )
		)
	|| ( (
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXfixes
			x11-libs/libXrender
			x11-libs/libXtst
			x11-libs/libXext
			xscreensaver? ( x11-libs/libXScrnSaver )
			xinerama? ( x11-libs/libXinerama )
		) virtual/x11 )"

RDEPEND="${DEPEND}
	sys-apps/usbutils
	java? ( >=virtual/jre-1.4 )
	virtual/eject
	|| ( (
			x11-apps/xmessage
			x11-apps/xsetroot
			x11-apps/xset
			x11-apps/xrandr
			x11-apps/mkfontdir
			|| ( x11-misc/xkeyboard-config x11-misc/xkbdata )
			x11-apps/setxkbmap
		) virtual/x11 )"

DEPEND="${DEPEND}
	xcomposite? ( || ( (
			x11-proto/compositeproto
			x11-proto/damageproto
			) <=x11-base/xorg-x11-6.9 )
		)
	|| ( (
			xscreensaver? ( x11-proto/scrnsaverproto )
			xinerama? ( x11-proto/xineramaproto )
			x11-apps/bdftopcf
		) virtual/x11 )
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/konsole-3.5.1-detach-send2all.patch
	${WORKDIR}/kdebase-3.5.2-patchset.diff"

src_unpack() {
	kde_src_unpack

	epatch "${WORKDIR}/patches/kdebase-3.5-startkde-gentoo.patch"

	# Avoid using imake (kde bug 114466).
	epatch "${WORKDIR}/patches/kdebase-3.5.0_beta2-noimake.patch"
	rm -f ${S}/configure

	epatch "${FILESDIR}/drkonqi-${PV}-splitdebug.patch"
}

src_compile() {
	local myconf="--with-dpms
	              $(use_with arts) $(use_with ldap)
	              $(use_with opengl gl) $(use_with ssl)
	              $(use_with samba) $(use_with openexr)
	              $(use_with lm_sensors sensors) $(use_with logitech-mouse libusb)
	              $(use_with ieee1394 libraw1394) $(use_with hal)
	              $(use_enable zeroconf dnssd)
				  $(use_with xcomposite composite)
				  $(use_with xscreensaver)
				  $(use_with xinerama)
				  --with-usbids=/usr/share/misc/usb.ids"

	if use pam; then
		myconf="${myconf} --with-pam=yes"
	else
		myconf="${myconf} --with-pam=no --with-shadow"
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
	doins ${FILESDIR}/agent-startup.sh

	exeinto ${KDEDIR}/shutdown
	doexe ${FILESDIR}/agent-shutdown.sh

	# freedesktop environment variables
	cat <<EOF > ${T}/xdg.sh
export XDG_DATA_DIRS="${KDEDIR}/share:/usr/share"
export XDG_CONFIG_DIRS="${KDEDIR}/etc/xdg"
EOF
	insinto ${KDEDIR}/env
	doins ${T}/xdg.sh

	# x11 session script
	cat <<EOF > ${T}/kde-${SLOT}
#!/bin/sh
exec ${KDEDIR}/bin/startkde
EOF
	exeinto /etc/X11/Sessions
	doexe ${T}/kde-${SLOT}

	# freedesktop compliant session script
	sed -e "s:@KDE_BINDIR@:${KDEDIR}/bin:g;s:Name=KDE:Name=KDE ${SLOT}:" \
		${S}/kdm/kfrontend/sessions/kde.desktop.in > ${T}/kde-${SLOT}.desktop
	insinto /usr/share/xsessions
	doins ${T}/kde-${SLOT}.desktop

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
		${D}/${KDEDIR}/share/config/kdm/kdmrc || die

	rmdir ${D}/${KDEDIR}/share/templates/.source/emptydir
}

pkg_postinst() {
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

	mkdir -p ${ROOT}${KDEDIR}/share/templates/.source/emptydir

	echo
	einfo "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	einfo "edit ${KDEDIR}/env/agent-startup.sh and"
	einfo "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
