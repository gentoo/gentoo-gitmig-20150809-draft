# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.0.4.ebuild,v 1.1 2002/10/05 19:29:29 danarmak Exp $
inherit kde-dist

IUSE="ldap pam motif encode oggvorbis cups ssl opengl samba qt31patch"

DESCRIPTION="KDE $PV - base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="x86"

newdepend ">=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	encode? ( >=media-sound/lame-3.89b )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	opengl? ( virtual/opengl )
	samba? ( net-fs/samba )" 
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

DEPEND="$DEPEND sys-apps/gzip"

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

src_unpack() {
    
    base_src_unpack

    # Enable this local USE flag to allow nspluginviewer to compile with qt 3.1.x.
    # It will patch nsplugins/viewer dir to cvs HEAD status.
    # THIS MAY BE UNSTABLE AND YOU SHOULD NOT USE IT UNLESS YOU REALLY HAVE TO
    # USE KDE 3.0.4 WITH QT >=3.1.X!
    # Also note that kdebase 3.0.3 will compile just fine with all version of QT.
    # However kdebase 3.0.4 introduced an nspluginviewer fix that necessitates this
    # additional patch to work with qt 3.1.
    if [ -n "`use qt31patch`" ]; then
	cd $S
	/bin/zcat "$FILESDIR/$P-nspluginviewer-qt31.diff.gz" | patch -p0 --
    fi

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
	sed -e "s:SessionTypes=:SessionTypes=kde-${PV},:" \
	-e "s:Session=${PREFIX}/share/config/kdm/Xsession:Session=/etc/X11/xdm/Xsession:"  kdmrc.orig > kdmrc    
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
