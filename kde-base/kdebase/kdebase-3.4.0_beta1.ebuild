# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.4.0_beta1.ebuild,v 1.7 2005/02/02 11:16:00 lanius Exp $

inherit kde-dist eutils

DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="~x86 ~amd64"
IUSE="arts cups java ldap ieee1394 lm_sensors logitech-mouse opengl pam samba ssl"

DEPEND="arts? ( ~kde-base/arts-${PV} )
	ldap? ( >=net-nds/openldap-2 )
	pam? ( sys-libs/pam )
	cups? ( net-print/cups )
	ssl? ( dev-libs/openssl )
	opengl? ( virtual/opengl )
	samba? ( >=net-fs/samba-3.0.4 )
	java? ( || ( virtual/jdk virtual/jre ) )
	>=dev-libs/cyrus-sasl-2
	lm_sensors? ( sys-apps/lm-sensors )
	logitech-mouse? ( dev-libs/libusb )
	ieee1394? ( sys-libs/libraw1394 )"
# TODO:
# - add support for dbus/hal for 'media:' ioslave:
#     hal? ( >=sys-apps/dbus-0.22-r3    (for proper Qt support)
#            >=sys-apps/hal-0.4 )
#   the 'hal' flag should become global,
#   since it's already used by 5 ebuilds.

RDEPEND="${DEPEND}
	sys-apps/eject"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${PVR}/startkde-gentoo.diff
}

src_compile() {
	myconf="$myconf --with-dpms"
	myconf="$myconf `use_with ldap` `use_with cups`"
	myconf="$myconf `use_with opengl gl` `use_with ssl`"
	myconf="$myconf `use_with arts`"

	use pam && myconf="$myconf --with-pam=yes" \
		|| myconf="$myconf --with-pam=no --with-shadow"

	if use java ; then
		if has_version virtual/jdk ; then
			myconf="$myconf --with-java=$(java-config --jdk-home)"
		else
			myconf="$myconf --with-java=$(java-config --jre-home)"
		fi
	else
		myconf="$myconf --without-java"
	fi

	kde_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde_src_compile make
}

src_install() {
	kde_src_install
	cd ${S}/kdm && make DESTDIR=${D} GENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice" install

	# Collision with kdemultimedia. Will be fixed in beta2.
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/scalable/apps/artsbuilder.svgz
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/scalable/apps/artscontrol.svgz

	if use pam; then
		insinto /etc/pam.d
		newins ${FILESDIR}/kde.pam kde
		newins ${FILESDIR}/kde-np.pam kde-np
	fi

	# startkde script
	sed -i -e "s:_KDEDIR_:${KDEDIR}:" ${D}/${KDEDIR}/bin/startkde

	# startup and shutdown scripts
	dodir ${KDEDIR}/env
	dodir ${KDEDIR}/shutdown

	insinto ${KDEDIR}/env
	insopts -m 644
	doins ${FILESDIR}/agent-startup.sh

	insinto ${KDEDIR}/shutdown
	insopts -m 755
	doins ${FILESDIR}/agent-shutdown.sh

	# x11 session script
	echo "#!/bin/sh
${KDEDIR}/bin/startkde" > ${T}/kde-${SLOT}
	exeinto /etc/X11/Sessions
	doexe ${T}/kde-${SLOT}

	# Create a kde.desktop file for freedesktop-compliant login managers
	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	sed -e "s:_PREFIX_:${KDEDIR}:" \
	    -e "s:_VERSION_:${SLOT}:" \
		${FILESDIR}/kde.desktop > ${T}/kde-${SLOT}.desktop
	doins ${T}/kde-${SLOT}.desktop

	# Customized kdm configuration file
	dodir ${KDEDIR}/share/config/kdm
	insinto ${KDEDIR}/share/config/kdm
	sed -e "s:_PREFIX_:${KDEDIR}:g" \
	    -e "s:_RANDOM_:${RANDOM}${RANDOM}:g" \
		${FILESDIR}/${PVR}/kdmrc > ${T}/kdmrc
	doins ${T}/kdmrc

	# Add 'pgo:' konqueror shortcut
	dodir ${KDEDIR}/share/services/searchprovider
	insinto ${KDEDIR}/share/services/searchprovider
	doins ${FILESDIR}/pgo.desktop

	rmdir ${D}/${KDEDIR}/share/templates/.source/emptydir
}

pkg_postinst() {
	# set the default kdm face icon if it's not already set by the system admin
	if [ ! -e "${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon" ]; then
		mkdir -p "${ROOT}${KDEDIR}/share/apps/kdm/faces"
		cp "${ROOT}${KDEDIR}/share/apps/kdm/pics/users/default1.png" \
			"${ROOT}${KDEDIR}/share/apps/kdm/faces/.default.face.icon"
	fi

	mkdir -p ${ROOT}${KDEDIR}/share/templates/.source/emptydir

	einfo "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	einfo "edit ${KDEDIR}/env/agent-startup.sh and ${KDEDIR}/shutdown/agent-shutdown.sh"
}
