# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.0.4-r3.ebuild,v 1.9 2003/09/06 23:54:21 msterret Exp $
inherit kde-dist eutils

IUSE="ldap pam motif encode oggvorbis cups ssl opengl samba"

DESCRIPTION="KDE $PV - base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="x86 ppc alpha"

newdepend ">=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	encode? ( >=media-sound/lame-3.89b )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	opengl? ( virtual/opengl )
	samba? ( net-fs/samba )
	sys-apps/gzip"
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

RDEPEND="${RDEPEND}
	sys-apps/eject"

myconf="$myconf --with-dpms --with-cdparanoia"

use ldap	&& myconf="$myconf --with-ldap" 	|| myconf="$myconf --without-ldap"
use pam		&& myconf="$myconf --with-pam"		|| myconf="$myconf --with-shadow"
use motif	&& myconf="$myconf --with-motif"	|| myconf="$myconf --without-motif"
use encode	&& myconf="$myconf --with-lame"		|| myconf="$myconf --without-lame"
use cups	&& myconf="$myconf --with-cups"		|| myconf="$myconf --disable-cups"
use oggvorbis 	&& myconf="$myconf --with-vorbis"	|| myconf="$myconf --without-vorbis"
use opengl	&& myconf="$myconf --with-gl"		|| myconf="$myconf --without-gl"
use ssl		&& myconf="$myconf --with-ssl"		|| myconf="$myconf --without-ssl"
use pam		&& myconf="$myconf --with-pam=yes"	|| myconf="$myconf --with-pam=no --with-shadow"

pkg_setup() {

	# It should generally be considered bad form to touch files in the
	# live filesystem, but we had a broken Xft.h out there, and to expect
	# all users to update X because of it is harsh.  Also, there is no
	# official fix to xfree for this issue as of writing.  See bug #9423
	# for more info.
	cd /usr/X11R6/include/X11/Xft
	if patch --dry-run -p0 < ${FILESDIR}/${PVR}/${P}-xft_h-fix.diff > /dev/null
	then
		einfo "Patching Xft.h to fix missing defines..."
		patch -p0 < ${FILESDIR}/${PVR}/${P}-xft_h-fix.diff > /dev/null || die
	fi
}

src_unpack() {

	kde_src_unpack

	# It will patch nsplugins/viewer dir to cvs HEAD status.
	# THIS MAY BE UNSTABLE
	# Also note that kdebase3.0.3 will compile just fine with all version of QT.
	# However kdebase 3.0.4 introduced an nspluginviewer fix that
	# necessitates this
	cd ${S}
	epatch "$FILESDIR/${PVR}/$P-nspluginviewer-qt31.diff.gz"

	# Apply this only if we are using a hacked Xft-1.1 Xft.h.
	if [ -n "`grep "End of Gentoo hack" /usr/X11R6/include/X11/Xft/Xft.h`" ]
	then
		cd ${S}; epatch ${FILESDIR}/${PVR}/${P}-xft1.1-fix.diff
	fi

	# fix konsole crashing for qt-3.1
	cd ${S}
	epatch ${FILESDIR}/${PVR}/${P}-konsole-qt31.diff
}

src_compile() {
	kde_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde_src_compile make
}

src_install() {

	kde_src_install

	# cf bug #5953
	insinto /etc/pam.d
	newins ${FILESDIR}/kscreensaver.pam kscreensaver
	newins ${FILESDIR}/kde.pam kde

	# startkde script
	cd ${D}/${KDEDIR}/bin
	epatch ${FILESDIR}/${PVR}/startkde-${PVR}-gentoo.diff
	mv startkde startkde.orig
	sed -e "s:_KDEDIR_:${KDEDIR}:" startkde.orig > startkde
	rm startkde.orig
	chmod a+x startkde

	# x11 session script
	cd ${T}
	echo "#!/bin/sh
${KDEDIR}/bin/startkde" > kde-${PV}
	chmod a+x kde-${PV}
	# old scheme - compatibility
	exeinto /usr/X11R6/bin/wm
	doexe kde-${PV}
	# new scheme - for now >=xfree-4.2-r3 only
	exeinto /etc/X11/Sessions
	doexe kde-${PV}

	cd ${D}/${PREFIX}/share/config/kdm || die
	mv kdmrc kdmrc.orig
	sed -e "s:SessionTypes=:SessionTypes=kde-${PV},:" \
	-e "s:Session=${PREFIX}/share/config/kdm/Xsession:Session=/etc/X11/xdm/Xsession:" kdmrc.orig > kdmrc
	rm kdmrc.orig

	#backup splashscreen images, so they can be put back when unmerging
	#mosfet or so.
	if [ ! -d ${KDEDIR}/share/apps/ksplash.default ]
	then
		cd ${D}/${KDEDIR}/share/apps
		cp -rf ksplash/ ksplash.default
	fi

	# Show gnome icons when choosing new icon for desktop shortcut
	dodir /usr/share/pixmaps
	mv ${D}/${KDEDIR}/share/apps/kdesktop/pics/* ${D}/usr/share/pixmaps/
	rm -rf ${D}/${KDEDIR}/share/apps/kdesktop/pics/
	cd ${D}/${KDEDIR}/share/apps/kdesktop/
	ln -sf /usr/share/pixmaps/ pics

	rmdir ${D}/${KDEDIR}/share/templates/.source/emptydir
}

pkg_postinst() {
	mkdir -p ${KDEDIR}/share/templates/.source/emptydir
}
