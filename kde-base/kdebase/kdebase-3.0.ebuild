# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Dan Armak <danarmak@gentoo.org>, Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.0.ebuild,v 1.2 2002/04/03 22:00:10 gbevin Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist

DESCRIPTION="${DESCRIPTION}Base"

newdepend ">=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	lame? ( >=media-sound/lame-3.89b )
	vorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	media-sound/cdparanoia
	opengl? ( virtual/opengl )" #this last for opengl screensavers
#	samba? ( net-fs/samba ) #use flag doesn't exist yet and we don't want such a heavy dep by deafult
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

src_unpack() {

    base_src_unpack
    kde_sandbox_patch ${S}/konsole ${S}/konsole/konsole

}

src_compile() {
    
    kde_src_compile myconf
    
    use ldap	&& myconf="$myconf --with-ldap" 	|| myconf="$myconf --without-ldap"
    use pam	&& myconf="$myconf --with-pam"		|| myconf="$myconf --with-shadow"
    use motif	&& myconf="$myconf --with-motif"	|| myconf="$myconf --without-motif"
    use lame	&& myconf="$myconf --with-lame"		|| myconf="$myconf --without-lame"
    use cups	&& myconf="$myconf --with-cups"		|| myconf="$myconf --disable-cups"
    use vorbis	&& myconf="$myconf --with-vorbis"	|| myconf="$myconf --without-vorbis"
    use opengl	&& myconf="$myconf --with-gl"		|| myconf="$myconf --without-gl"
    use ssl	&& myconf="$myconf --with-ssl"		|| myconf="$myconf --without-ssl"
    use pam	&& myconf="$myconf --with-pam=yes"	|| myconf="$myconf --with-pam=no --with-shadow"
    
    myconf="$myconf --with-dpms --with-cdparanoia"
    
    kde_src_compile configure make

}


src_install() {

    kde_src_install

    insinto /etc/pam.d
    newins ${FILESDIR}/kscreensaver.pam kscreensaver
    newins kde.pamd kde

    # startkde script
    cd ${D}/${KDEDIR}/bin
    patch -p0 < ${FILESDIR}/startkde-3.0-gentoo.diff
    mv startkde startkde.orig
    sed -e "s:_KDEDIR_:${KDEDIR}:" startkde.orig > startkde
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

    dodir ${KDEDIR}/share/templates/.source/emptydir
    
    cd ${D}/${KDEDIR}/share/config/kdm || die
    mv kdmrc kdmrc.orig
    sed -e 's:SessionTypes=:SessionTypes=kde-3.0,kde-2.2.2,:' kdmrc.orig > kdmrc
    rm kdmrc.orig
  
}

