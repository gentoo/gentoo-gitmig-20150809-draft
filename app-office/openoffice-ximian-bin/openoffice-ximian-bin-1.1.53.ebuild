# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-ximian-bin/openoffice-ximian-bin-1.1.53.ebuild,v 1.3 2004/11/07 09:01:44 mr_bones_ Exp $

inherit rpm

OO_VER=1.1.1
INSTDIR="/opt/Ximian-OpenOffice"
S="${WORKDIR}/usr"
DESCRIPTION="Ximian-ized version of OpenOffice.org, a full office productivity suite."
HOMEPAGE="http://ooo.ximian.com"
SRC_URI="ftp://ftp.ximian.com/pub/xd-unstable/suse-90-i586/ooo-1.1.1-0.ximian.8.1.1.53.i586.rpm
	ftp://ftp.ximian.com/pub/xd-unstable/suse-90-i586/ooo-fonts-1.1.3-0.ximian.8.2.noarch.rpm
	mirror://openoffice/contrib/dictionaries/dicooo/DicOOo.sxw"

LICENSE="|| ( LGPL-2 SISSL-1.1 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome kde"

RDEPEND="virtual/libc
	!=sys-libs/glibc-2.3.1*
	>=dev-lang/perl-5.0
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnome-2.2
	>=gnome-base/gnome-vfs-2.0
	>=net-print/libgnomecups-0.1.4
	>=net-print/gnome-cups-manager-0.16
	>=dev-libs/libxml2-2.0
	>=media-libs/libart_lgpl-2.3.13
	>=x11-libs/startup-notification-0.5
	media-fonts/ttf-bitstream-vera
	media-libs/fontconfig
	media-libs/libpng
	sys-devel/flex
	sys-devel/bison
	virtual/x11
	app-arch/zip
	app-arch/unzip
	dev-libs/expat
	net-libs/linc
	!app-office/openoffice-ximian
	virtual/lpr
	ppc? ( >=sys-devel/gcc-3.2.1 )
	>=media-libs/freetype-2.1.4"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_unpack() {
	rpm_src_unpack
}

src_install() {

	# Sandbox issues; bug #11838
	addpredict "/user"
	addpredict "/share"
	addpredict "/dev/dri"
	addpredict "/usr/bin/soffice"
	addpredict "/pspfontcache"
	addpredict "/opt/OpenOffice.org/foo.tmp"
	addpredict "/opt/OpenOffice.org/delme"

	# Autoresponse file for main installation
	cat > ${T}/rsfile-global <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_NETWORK
		INSTALLATIONTYPE=STANDARD
		DESTINATIONPATH=<destdir>
		OUTERPATH=
		LOGFILE=
		LANGUAGELIST=<LANGUAGE>

		[JAVA]
		JavaSupport=preinstalled_or_none
	END_RS

	# Autoresponse file for user installation
	cat > ${T}/rsfile-local <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_WORKSTATION
		INSTALLATIONTYPE=WORKSTATION
		DESTINATIONPATH=<home>/.xopenoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	# Fixing install location in response file
	sed -e "s|<destdir>|${D}${INSTDIR}|" \
		${T}/rsfile-global > ${T}/autoresponse

	einfo "Installing Ximian-OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}/lib/ooo-1.1
	cp -R * ${D}${INSTDIR}

	#Fix for parallel install
	sed -i -e s/sversionrc/xversionrc/g ${D}${INSTDIR}/program/bootstraprc ${D}${INSTDIR}/program/instdb.ins

	echo
	einfo "Removing build root from registry..."
	# Remove totally useless stuff.
	rm -f ${D}${INSTDIR}/program/{setup.log,sopatchlevel.sh}
	# Remove build root from registry and co
	egrep -rl "${D}" ${D}${INSTDIR}/* | \
		xargs -i perl -pi -e "s|${D}||g" {} || :

	einfo "Fixing permissions..."
	# Fix permissions
	find ${D}${INSTDIR}/ -type f -exec chmod a+r {} \;
	chmod a+x ${D}${INSTDIR}/share/config/webcast/*.pl
	find ${D}${INSTDIR}/ -type d -exec chmod a+rx {} \;

	# Fix symlinks
	dosym program/setup ${INSTDIR}/setup

	# Install user autoresponse file
	insinto /etc/ximian-openoffice
	sed -e "s|<pv>|${OO_VER}|g" ${T}/rsfile-local > ${T}/autoresponse-${OO_VER}.conf
	doins ${T}/autoresponse-${OO_VER}.conf

	# Install wrapper script
	exeinto /usr/bin
	sed -e "s|<pv>|${OO_VER}|g" \
		${FILESDIR}/${OO_VER}/xooffice-wrapper-1.3 > ${T}/xooffice
	doexe ${T}/xooffice

	# Component symlinks
	for app in calc draw impress html math writer setup; do
		dosym xooffice /usr/bin/xoo${app}
	done

	# Install ximian icons
	cd ${S}/share/pixmaps
	insinto /usr/share/pixmaps
	doins *.png

	cd ${S}/share/gnome/ximian/applications/
	rm -f *1.1*
	sed -i -e s/'=oo'/'=xoo'/g *.desktop

	einfo "Installing Menu shortcuts and mime info (need \"gnome\" or \"kde\" in USE)..."
	if use gnome
	then
		insinto /usr/share/applications
		doins *.desktop
		insinto /usr/share/application-registry
		doins ${FILESDIR}/${OO_VER}/ximian-openoffice.applications
		insinto /usr/share/mime-info
		doins ${FILESDIR}/${OO_VER}/ximian-openoffice.keys
	fi

	if use kde
	then
		insinto /usr/share/applnk/Ximian-OpenOffice.org
		doins *.desktop
	fi

	# Install corrected Symbol Font
	insinto /usr/X11R6/lib/X11/fonts/truetype/
	doins ${S}/share/fonts/default/TrueType/symbol/*.ttf

	# Install missing Dictionary installer
	insinto ${INSTDIR}/share/dict/ooo
	doins ${DISTDIR}/DicOOo.sxw

	# Remove unneeded stuff
	rm -rf ${D}${INSTDIR}/share/cde

	# Fix instdb.ins, to *not* install local copies of these
	for entry in Kdeapplnk Kdemimetext Kdeicons Gnome_Apps Gnome_Icons Gnome2_Apps; do
		perl -pi -e "/^File gid_File_Extra_$entry/ .. /^End/ and (\
			s|^\tSize\s+\= .*|\tSize\t\t = 0;\r| or \
			s|^\tArchiveFiles\s+\= .*|\tArchiveFiles\t = 0;\r| or \
			s|^\tArchiveSize\s+\= .*|\tArchiveSize\t = 0;\r| or \
			s|^\tContains\s+\= .*|\tContains\t = ();\r| or \
			s|\t\t\t\t\t\".*|\r|g)" \
			${D}${INSTDIR}/program/instdb.ins
	done

	# Make sure these do not get nuked.
	keepdir ${INSTDIR}/user/registry/res/en-us/org/openoffice/{Office,ucb}
	keepdir ${INSTDIR}/user/psprint/{driver,fontmetric}
	keepdir ${INSTDIR}/user/{autocorr,backup,plugin,store,temp,template}
}

pkg_postinst() {

	einfo "******************************************************************"
	einfo " To start Ximian-OpenOffice.org, run:"
	einfo
	einfo "   $ xooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   xoocalc, xoodraw, xooimpress, xoomath, xooweb or xoowriter"
	einfo
	einfo "******************************************************************"
	einfo
	einfo "******************************************************************"
	einfo " If you are upgrading from an older Ximian-OpenOffice.org"
	einfo " you will have to redo your settings."
	einfo
	einfo "******************************************************************"
}
