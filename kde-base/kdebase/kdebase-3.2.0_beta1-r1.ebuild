# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.2.0_beta1-r1.ebuild,v 1.5 2004/01/11 13:47:10 lanius Exp $
inherit kde-dist eutils

IUSE="ldap pam motif encode oggvorbis cups ssl opengl samba java"
DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="~x86"

DEPEND="media-sound/cdparanoia
	ldap? ( net-nds/openldap )
	pam? ( sys-libs/pam )
	motif? ( x11-libs/openmotif )
	encode? ( media-sound/lame )
	oggvorbis? ( media-libs/libvorbis )
	cups? ( net-print/cups )
	ssl? ( dev-libs/openssl )
	opengl? ( virtual/opengl )
	samba? ( net-fs/samba )
	java? ( virtual/jdk )
	>=media-libs/freetype-2
	dev-util/pkgconfig"
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

RDEPEND="sys-apps/eject"

myconf="$myconf --with-dpms --with-cdparanoia"

use ldap	&& myconf="$myconf --with-ldap" 	|| myconf="$myconf --without-ldap"
use motif	&& myconf="$myconf --with-motif"	|| myconf="$myconf --without-motif"
use encode	&& myconf="$myconf --with-lame"		|| myconf="$myconf --without-lame"
use cups	&& myconf="$myconf --with-cups"		|| myconf="$myconf --disable-cups"
use oggvorbis 	&& myconf="$myconf --with-vorbis"	|| myconf="$myconf --without-vorbis"
use opengl	&& myconf="$myconf --with-gl"		|| myconf="$myconf --without-gl"
use ssl		&& myconf="$myconf --with-ssl"		|| myconf="$myconf --without-ssl"
use pam		&& myconf="$myconf --with-pam=yes"	|| myconf="$myconf --with-pam=no --with-shadow"
use java	&& myconf="$myconf --with-java=$(java-config --jdk-home)"	|| myconf="$myconf --without-java"

PATCHES=""

src_unpack() {
	kde_src_unpack
}

src_compile() {
	kde_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde_src_compile make
}

src_install() {

	kde_src_install
	cd ${S}/kdm && make DESTDIR=${D} GENKDMCONF_FLAGS="--no-old --no-backup" install

	insinto /etc/pam.d
	newins ${FILESDIR}/kde.pam kde
	# kde-np is new requirement for 3.2 autologins - #33690
	newins ${FILESDIR}/kde-np.pam kde-np

	# startkde script
	cd ${D}/${KDEDIR}/bin
	epatch ${FILESDIR}/${PVR}/startkde-${PVR}-gentoo.diff
	mv startkde startkde.orig
	sed -e "s:_KDEDIR_:${KDEDIR}:" startkde.orig > startkde
	rm startkde.orig
	chmod a+x startkde

	# kcontrol modules
	cd ${D}/${KDEDIR}/etc/xdg/menus
	ln -s default_kde-settings.menu kde-settings.menu
	ln -s default_kde-information.menu kde-information.menu
	ln -s default_kde-screensavers.menu kde-screensavers.menu

	# x11 session script
	cd ${T}
	echo "#!/bin/sh
${KDEDIR}/bin/startkde" > kde-${PV}
	chmod a+x kde-${PV}
	exeinto /etc/X11/Sessions
	doexe kde-${PV}

	cd ${D}/${KDEDIR}/share/config/kdm || die
	dodir ${KDEDIR}/share/config/kdm/sessions
	sed -e "s:_PREFIX_:${PREFIX}:g" \
	    -e "s:_RANDOM_:${RANDOM}${RANDOM}:g" \
	${FILESDIR}/${PVR}/kdmrc > kdmrc
	sed -e "s:_PREFIX_:${PREFIX}:g" ${FILESDIR}/${PVR}/Xsetup > Xsetup

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
}
