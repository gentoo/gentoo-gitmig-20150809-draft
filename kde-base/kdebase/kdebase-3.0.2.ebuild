# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.0.2.ebuild,v 1.13 2002/08/29 14:59:56 danarmak Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="x86 ppc sparc sparc64"

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
	>=media-libs/freetype-2" 
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

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

# fix for verwilst's gcc 3.1 & antialiasing problem
PATCHES="$FILESDIR/${P}-fonts.cpp.patch"

src_compile() {

    kde_src_compile myconf configure
    kde_remove_flag kdm/kfrontend -fomit-frame-pointer
    kde_src_compile make

}

src_install() {

    kde_src_install

    insinto /etc/pam.d
    newins ${FILESDIR}/kscreensaver.pam kscreensaver
    newins kde.pamd kde

    # startkde script
    cd ${D}/${KDEDIR}/bin
    patch -p0 < ${FILESDIR}/startkde-${PVR}-gentoo.diff || die
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

    cd ${D}/${KDEDIR}/share/config/kdm || die
    mv kdmrc kdmrc.orig
    sed -e "s:SessionTypes=:SessionTypes=kde-3.0,kde-2.2.2,:" kdmrc.orig > kdmrc
    rm kdmrc.orig

    #backup splashscreen images, so they can be put back when unmerging 
    #mosfet or so.
    if [ ! -d ${KDEDIR}/share/apps/ksplash.default ]
    then
        cd ${D}/${KDEDIR}/share/apps
        cp -rf ksplash/ ksplash.default
    fi
    
    # Show gnome icons when choosing new icon for desktop shortcut
    mkdir -p ${D}/usr/share/pixmaps
    mv ${D}/${KDEDIR}/share/apps/kdesktop/pics/* ${D}/usr/share/pixmaps/
    rm -rf ${D}/${KDEDIR}/share/apps/kdesktop/pics/
    cd ${D}/${KDEDIR}/share/apps/kdesktop/
    ln -sf /usr/share/pixmaps/ pics

    rmdir ${D}/${KDEDIR}/share/templates/.source/emptydir

}

pkg_postinst() {
    mkdir -p ${KDEDIR}/share/templates/.source/emptydir
}
