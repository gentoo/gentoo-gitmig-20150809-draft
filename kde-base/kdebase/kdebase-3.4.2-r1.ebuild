# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.4.2-r1.ebuild,v 1.1 2005/08/06 10:27:24 flameeyes Exp $

inherit kde-dist eutils

DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="arts cups java ldap ieee1394 hal lm_sensors logitech-mouse openexr opengl pam samba ssl"
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
	hal? ( =sys-apps/dbus-0.23*
	       =sys-apps/hal-0.4* )"

RDEPEND="${DEPEND}
	java? ( >=virtual/jre-1.4 )
	virtual/eject"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	kde_src_unpack

	epatch "${FILESDIR}/kdebase-3.4.1-startkde-gentoo.patch"

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdebase-3.4-configure.patch"

	# Avoid name-filter expansion for files that do exists (bug #101501)
	epatch "${FILESDIR}/kdebase-3.4.2-konqueror-filter.patch"

	# For the configure patch.
	make -f admin/Makefile.common || die
}

src_compile() {
	local myconf="--with-dpms
	              $(use_with arts) $(use_with ldap)
	              $(use_with cups) $(use_with opengl gl)
	              $(use_with ssl) $(use_with samba) $(use_with openexr)
	              $(use_with lm_sensors sensors) $(use_with logitech-mouse libusb)
	              $(use_with ieee1394 libraw1394) $(use_with hal)"

	if use pam; then
		myconf="${myconf} --with-pam=yes"
	else
		myconf="${myconf} --with-pam=no --with-shadow"
	fi

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
