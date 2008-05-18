# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-startkde/kdebase-startkde-3.5.9.ebuild,v 1.7 2008/05/18 22:15:48 maekke Exp $

KMNAME=kdebase
KMNOMODULE=true
KMEXTRACTONLY="kdm/kfrontend/sessions/kde.desktop.in startkde"
EAPI="1"
inherit multilib kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-08.tar.bz2"

DESCRIPTION="startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

# The kde apps called from the startkde script.
# kdesktop, kicker etc are started because they put files in $KDEDIR/share/autostart
# and so in theory they aren't strictly necessary deps.
RDEPEND="x11-apps/xmessage
		x11-apps/xsetroot
		x11-apps/xset
		x11-apps/xrandr
		x11-apps/mkfontdir
		x11-apps/xprop
>=kde-base/kdesktop-${PV}:${SLOT}
>=kde-base/kcminit-${PV}:${SLOT}
>=kde-base/ksmserver-${PV}:${SLOT}
>=kde-base/kwin-${PV}:${SLOT}
>=kde-base/kpersonalizer-${PV}:${SLOT}
>=kde-base/kreadconfig-${PV}:${SLOT}
>=kde-base/ksplashml-${PV}:${SLOT}"

src_compile() {
	# Patch the startkde script to setup the environment for KDE 4.0
	# Add our KDEDIR
	sed -i -e "s#@REPLACE_PREFIX@#${PREFIX}#" \
		"${S}/startkde" || die "Sed for PREFIX failed."

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Complete LDPATH
	sed -i -e "s#@REPLACE_LIBS@#${_libdirs}#" \
		"${S}/startkde" || die "Sed for LDPATH failed."
}

src_install() {
	# startkde script
	exeinto "${KDEDIR}/bin"
	doexe startkde

	# startup and shutdown scripts
	insinto "${KDEDIR}/env"
	doins "${WORKDIR}/patches/agent-startup.sh"

	exeinto "${KDEDIR}/shutdown"
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
}

pkg_postinst () {
	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${KDEDIR}/env/agent-startup.sh and"
	elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
