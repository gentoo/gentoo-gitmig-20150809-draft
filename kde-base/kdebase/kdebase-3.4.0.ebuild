# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.4.0.ebuild,v 1.2 2005/03/18 16:33:30 morfic Exp $

inherit kde-dist eutils

DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="arts cups java ldap ieee1394 hal lm_sensors logitech-mouse opengl pam samba ssl"
# hal: enables hal backend for 'media:' ioslave

DEPEND="arts? ( ~kde-base/arts-${PV} )
	pam? ( kde-base/kdebase-pam )
	>=dev-libs/cyrus-sasl-2
	ldap? ( >=net-nds/openldap-2 )
	cups? ( net-print/cups )
	ssl? ( dev-libs/openssl )
	opengl? ( virtual/opengl )
	samba? ( >=net-fs/samba-3.0.4 )
	lm_sensors? ( sys-apps/lm_sensors )
	logitech-mouse? ( dev-libs/libusb )
	ieee1394? ( sys-libs/libraw1394 )
	hal? ( >=sys-apps/dbus-0.22-r3
	       >=sys-apps/hal-0.4 )"

RDEPEND="${DEPEND}
	java? ( || ( virtual/jdk virtual/jre ) )
	sys-apps/eject"

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-startkde-gentoo.patch
}

src_compile() {
	myconf="--with-dpms"
	myconf="${myconf} $(use_with arts)"
	myconf="${myconf} $(use_with ldap) $(use_with cups)"
	myconf="${myconf} $(use_with opengl gl) $(use_with ssl)"
	myconf="${myconf} $(use_with hal)"

	use pam && myconf="${myconf} --with-pam=yes" \
		|| myconf="${myconf} --with-pam=no --with-shadow"

	# the java test is problematic (see kde bug 100729) and
	# useless. All that's needed for java applets to work is
	# to have the 'java' executable in PATH.
	myconf="${myconf} --without-java"

	kde_src_compile
}

src_install() {
	kde_src_install
	cd ${S}/kdm && make DESTDIR=${D} GENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice" install

	# startup and shutdown scripts
	insinto ${KDEDIR}/env
	insopts -m 644
	doins ${FILESDIR}/agent-startup.sh

	insinto ${KDEDIR}/shutdown
	insopts -m 755
	doins ${FILESDIR}/agent-shutdown.sh

	# x11 session script
	cat <<EOF > ${T}/kde-${SLOT}
#!/bin/sh
exec ${KDEDIR}/bin/startkde
EOF
	exeinto /etc/X11/Sessions
	doexe ${T}/kde-${SLOT}

	# Create a kde.desktop file for freedesktop-compliant login managers
	sed -e "s:_PREFIX_:${KDEDIR}:" \
	    -e "s:_VERSION_:${SLOT}:" \
		${FILESDIR}/kde.desktop > ${T}/kde-${SLOT}.desktop
	insinto /usr/share/xsessions
	doins ${T}/kde-${SLOT}.desktop

	# Customize the kdmrc configuration
	sed -i -e "s:#SessionsDirs=:SessionsDirs=/usr/share/xsessions\n#SessionsDirs=:" \
	       -e "s:#GreetFont=:GreetFont=Sans Serif,24,-1,5,50,0,0,0,0,0\n#GreetFont=:" \
	       -e "s:#StdFont=:StdFont=Sans Serif,12,-1,5,50,0,0,0,0,0\n#StdFont=:" \
	       -e "s:#FailFont=:FailFont=Sans Serif,12,-1,5,75,0,0,0,0,0\n#FailFont=:" \
	       -e "s:#AntiAliasing=:AntiAliasing=true\n#AntiAliasing=:" \
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

	mkdir -p ${ROOT}${KDEDIR}/share/templates/.source/emptydir

	echo
	einfo "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	einfo "edit ${KDEDIR}/env/agent-startup.sh and"
	einfo "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
