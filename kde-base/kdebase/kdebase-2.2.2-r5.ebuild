# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-2.2.2-r5.ebuild,v 1.1 2003/04/11 00:31:56 hannes Exp $

IUSE="ssl motif ldap encode cups oggvorbis pam"
inherit kde-dist eutils

DESCRIPTION="KDE $PV - base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="x86 sparc"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-${PV}-${PN}.diff
	mirror://kde/security_patches/post-${PV}-${PN}-thumbnail.diff"

export MAKEOPTS="${MAKEOPTS} -j1"

newdepend ">=media-sound/cdparanoia-3.9.8
	ldap? ( >=net-nds/openldap-1.2 )
	pam? ( >=sys-libs/pam-0.73 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	encode? ( >=media-sound/lame-3.89b )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta1 )
	cups? ( net-print/cups )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	media-libs/lcms"
#	opengl? ( virtual/opengl )" #this last for opengl screensavers
#	samba? ( net-fs/samba ) #use flag doesn't exist yet and we don't want such a heavy dep by deafult
#	lm_sensors? ( ?/lm_sensors ) # ebuild doesn't exist yet

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/post-${PV}-${PN}.diff
	cd ${S}/kioslave/thumbnail
	epatch ${DISTDIR}/post-${PV}-${PN}-thumbnail.diff
	kde_sandbox_patch ${S}/konsole/src
}

src_compile() {

	kde_src_compile myconf

	use ldap	&& myconf="$myconf --with-ldap" || myconf="$myconf --without-ldap"
	use pam	&& myconf="$myconf --with-pam"	|| myconf="$myconf --with-shadow"
	use motif					|| myconf="$myconf --without-motif"
	use encode					|| myconf="$myconf --without-lame"
	use cups					|| myconf="$myconf --disable-cups"
	use oggvorbis				|| myconf="$myconf --without-vorbis"
	#use opengl					||
	myconf="$myconf --without-gl"
	use ssl					|| myconf="$myconf --without-ssl"

	kde_src_compile configure make
}


src_install() {

	kde_src_install

	insinto /etc/pam.d
	newins ${FILESDIR}/kscreensaver.pam kscreensaver
	newins kde.pamd kde

	cd ${D}/${KDEDIR}/bin
	rm -f ./startkde
	sed -e "s:_KDEDIR_:${KDEDIR}:" ${FILESDIR}/${PVR}/startkde-${PVR}-gentoo > startkde
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

	cd ${D}/${KDEDIR}/share/config/kdm
	mv kdmrc kdmrc.orig
	sed -e 's/SessionTypes=/SessionTypes=kde-2.2.2,kde-3.0,xsession,/' kdmrc.orig | cat > kdmrc
	rm kdmrc.orig

	rm -rf ${D}/${KDEDIR}/share/templates/.source/emptydir
}

pkg_postinst() {
	# an empty dir that would otherwise be unmerged with the previous instance
	# dodir ${KDEDIR}/share/templates/.source/emptydir
	# temorary fix (bug #846) until portage tracks merged dirs' mtimes
	addwrite ${KDEDIR}/share/templates/.source
	mkdir -p ${KDEDIR}/share/templates/.source/emptydir
}
