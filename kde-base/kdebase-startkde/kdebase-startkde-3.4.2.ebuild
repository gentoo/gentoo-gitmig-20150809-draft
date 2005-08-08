# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-startkde/kdebase-startkde-3.4.2.ebuild,v 1.2 2005/08/08 22:23:32 kloeri Exp $

KMNAME=kdebase
KMNOMODULE=true
KMEXTRACTONLY="kdm/kfrontend/sessions/kde.desktop.in startkde"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

# The kde apps called from the startkde script.
# kdesktop, kicker etc are started because they put files in $KDEDIR/share/autostart
# and so in theory they aren't strictly necessary deps.
RDEPEND="$RDEPEND
$(deprange $PV $MAXKDEVER kde-base/kdesktop)
$(deprange 3.4.1 $MAXKDEVER kde-base/kcminit)
$(deprange 3.4.1 $MAXKDEVER kde-base/ksmserver)
$(deprange $PV $MAXKDEVER kde-base/kwin)
$(deprange $PV $MAXKDEVER kde-base/kpersonalizer)
$(deprange 3.4.1 $MAXKDEVER kde-base/kreadconfig)
$(deprange $PV $MAXKDEVER kde-base/ksplashml)"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# startkde script
	epatch ${FILESDIR}/${PF}-gentoo.patch
	exeinto ${KDEDIR}/bin
	doexe startkde

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
}

pkg_postinst () {
	echo
	einfo "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	einfo "edit ${KDEDIR}/env/agent-startup.sh and"
	einfo "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
