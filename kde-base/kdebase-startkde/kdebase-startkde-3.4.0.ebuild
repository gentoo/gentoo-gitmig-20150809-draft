# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-startkde/kdebase-startkde-3.4.0.ebuild,v 1.3 2005/03/21 03:59:16 weeve Exp $

KMNAME=kdebase
KMNOMODULE=true
KMEXTRACTONLY="kdm/kfrontend/sessions/kde.desktop.in startkde"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

# The kde apps called from the startkde script.
# kdesktop, kicker etc are started because they put files in $KDEDIR/share/autostart
# and so in theory they aren't strictly necessary deps.
RDEPEND="$RDEPEND
$(deprange $PV $MAXKDEVER kde-base/kdesktop)
$(deprange $PV $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/ksmserver)
$(deprange $PV $MAXKDEVER kde-base/kwin)
$(deprange $PV $MAXKDEVER kde-base/kpersonalizer)
$(deprange $PV $MAXKDEVER kde-base/kreadconfig)
$(deprange $PV $MAXKDEVER kde-base/ksplashml)"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {

	# startkde script
	dodir $KDEDIR/bin
	cd $D/$KDEDIR/bin
	cp $S/startkde .
	patch -p0 < $FILESDIR/startkde-$PV-gentoo.diff
	sed -i -e "s:_KDEDIR_:${KDEDIR}:" startkde
	chmod a+x startkde

	# startup and shutdown scripts
	insopts -m0755
	insinto ${KDEDIR}/env
	doins $FILESDIR/agent-startup.sh
	insinto $KDEDIR/shutdown
	doins $FILESDIR/agent-shutdown.sh

	# x11 session script - old style
	cd ${T}
	echo "#!/bin/sh
${KDEDIR}/bin/startkde" > kde-$SLOT
	chmod a+x kde-$SLOT
	exeinto /etc/X11/Sessions
	doexe kde-$SLOT

	# x11 session - new style
	dodir /usr/share/xsessions
	sed -e "s:@KDE_BINDIR@:${KDEDIR}/bin:g;s:Name=KDE:Name=KDE $PV:" \
		$S/kdm/kfrontend/sessions/kde.desktop.in > $D/usr/share/xsessions/kde-$SLOT.desktop
}

pkg_postinst () {
	einfo "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	einfo "edit $KDEDIR/env/agent-startup.sh and $KDEDIR/shutdown/agent-shutdown.sh"
}
