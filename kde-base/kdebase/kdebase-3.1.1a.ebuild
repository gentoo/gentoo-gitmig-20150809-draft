# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.1.1a.ebuild,v 1.2 2003/04/11 10:22:51 danarmak Exp $
inherit kde-dist eutils

IUSE="ldap pam motif encode oggvorbis cups ssl opengl samba java"
DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="x86 ~ppc ~sparc ~alpha"

newdepend ">=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( virtual/motif )
	encode? ( >=media-sound/lame-3.89b )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	opengl? ( virtual/opengl )
	samba? ( net-fs/samba )
	java? ( virtual/jdk )
	>=media-libs/freetype-2" 
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

RDEPEND="$RDEPEND sys-apps/eject"

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
use java	&& myconf="$myconf --with-java=$(java-config --jdk-home)"	|| myconf="$myconf --without-java"

src_compile() {
	kde_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde_src_compile make
}

src_install() {

	kde_src_install

	# cf bug #5953
	insinto /etc/pam.d
	#newins ${FILESDIR}/kscreensaver.pam kscreensaver
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
	exeinto /etc/X11/Sessions
	doexe kde-${PV}

	cd ${D}/${KDEDIR}/share/config/kdm || die
	sed -e "s:SessionTypes=:SessionTypes=kde-${PV},:" \
	-e "s:Session=${PREFIX}/share/config/kdm/Xsession:Session=/etc/X11/xdm/Xsession:" \
	${FILESDIR}/${PVR}/kdmrc > kdmrc
	cp ${FILESDIR}/${PVR}/backgroundrc .

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
	
einfo "If you want to floppy:/ kioslave to work, please emerge the mtools package."
einfo "This ioslave allows you to use fat/vfat filesystems (not only on floppies)"
einfo "without mounting them. If you don't know what this is for, you can probably"
einfo "go with the usual mounting method."
	
}
