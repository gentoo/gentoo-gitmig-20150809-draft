# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-data/kdebase-data-3.4.0_rc1-r1.ebuild,v 1.2 2005/03/13 19:01:52 danarmak Exp $

KMNAME=kdebase
KMNOMODULE=true
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Icons and various .desktop files from kdebase, and the startkde script"
KEYWORDS="~x86 ~amd64"
IUSE=""

# The kde apps called from the startkde script.
# kdesktop, kicker etc are started because they put files in $KDEDIR/share/autostart
# and so in theory they aren't strictly necessary deps.
RDEPEND="$RDEPEND
$(deprange $PV $MAXKDEVER kde-base/kdesktop)
$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/ksmserver)
$(deprange $PV $MAXKDEVER kde-base/kwin)
$(deprange $PV $MAXKDEVER kde-base/kpersonalizer)
$(deprange 3.4.0_beta2 $MAXKDEVER kde-base/kreadconfig)
$(deprange $PV $MAXKDEVER kde-base/ksplashml)
!kde-base/kdebase-l10n !kde-base/kdebase-startkde !kde-base/kdebase-pics" # replaced these three ebuilds

KMEXTRACTONLY="kdm/kfrontend/sessions/kde.desktop.in startkde"
KMEXTRA="l10n pics"

src_install() {
	kde-meta_src_install

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
