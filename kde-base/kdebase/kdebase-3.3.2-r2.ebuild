# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase/kdebase-3.3.2-r2.ebuild,v 1.5 2005/03/24 23:39:17 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE base packages: the desktop, panel, window manager, konqueror..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="ldap pam cups ssl opengl samba java arts"

DEPEND="arts? ( ~kde-base/arts-${PV//3.3/1.3} )
	pam? ( kde-base/kdebase-pam )
	ldap? ( net-nds/openldap )
	cups? ( net-print/cups )
	ssl? ( dev-libs/openssl )
	opengl? ( virtual/opengl )
	samba? ( >=net-fs/samba-3.0.1 )
	java? ( || ( virtual/jdk virtual/jre ) )"

RDEPEND="${DEPEND}
	sys-apps/eject"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/konsole-${PV}.patch
	epatch ${FILESDIR}/post-3.3.2-kdebase-htmlframes2.patch
	epatch ${FILESDIR}/${PVR}/startkde-${PVR}-gentoo.diff
}

src_compile() {
	myconf="$myconf --with-dpms"
	myconf="$myconf `use_with ldap` `use_with cups`"
	myconf="$myconf `use_with opengl gl` `use_with ssl`"
	myconf="$myconf `use_with arts`"

	use pam \
		&& myconf="$myconf --with-pam=yes" \
		|| myconf="$myconf --with-pam=no --with-shadow"

	if use java ; then
		if has_version virtual/jdk ; then
			myconf="$myconf --with-java=$(java-config --jdk-home)"
		else
			myconf="$myconf --with-java=$(java-config --jre-home)"
		fi
	else
		myconf="$myconf --without-java"
	fi

	kde_src_compile myconf configure
	kde_remove_flag kdm/kfrontend -fomit-frame-pointer
	kde_src_compile make
}

src_install() {
	kde_src_install
	cd ${S}/kdm && make DESTDIR=${D} GENKDMCONF_FLAGS="--no-old --no-backup --no-in-notice" install

	# startkde script
	sed -i -e "s:_KDEDIR_:${KDEDIR}:" ${D}/${KDEDIR}/bin/startkde

	# startup and shutdown scripts
	dodir ${KDEDIR}/env
	dodir ${KDEDIR}/shutdown

	insinto ${KDEDIR}/env
	insopts -m 644
	doins ${FILESDIR}/agent-startup.sh

	insinto ${KDEDIR}/shutdown
	insopts -m 755
	doins ${FILESDIR}/agent-shutdown.sh

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
	sed -e "s:_PREFIX_:${PREFIX}:g" \
	    -e "s:_RANDOM_:${RANDOM}${RANDOM}:g" \
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

	# Create a kde.desktop file so that a KDE entry will be present in gdm
	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	newins ${FILESDIR}/kde.desktop kde-${PV}.desktop
	sed -i -e "s:_PREFIX_:${KDEDIR}:;s:_VERSION_:${PV}:" \
		${D}/usr/share/xsessions/kde-${PV}.desktop
}

pkg_postinst() {
	mkdir -p ${KDEDIR}/share/templates/.source/emptydir

	einfo "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	einfo "edit $KDEDIR/env/agent-startup.sh and $KDEDIR/shutdown/agent-shutdown.sh"
}
