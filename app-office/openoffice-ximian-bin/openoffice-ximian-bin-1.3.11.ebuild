# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-ximian-bin/openoffice-ximian-bin-1.3.11.ebuild,v 1.2 2005/07/07 12:46:11 agriffis Exp $

inherit fdo-mime rpm

IUSE="gnome java kde"

OO_VER="1.1.4"
XOOPATH="http://red-carpet.go-ooo.org/ooo-645/nld-9-i586"
XOOVER="${OO_VER}-0.2.1"
INSTDIR="/opt/Ximian-OpenOffice"
S="${WORKDIR}/usr"
DESCRIPTION="Ximian-ized version of OpenOffice.org, a full office productivity suite."
HOMEPAGE="http://go-ooo.org"
SRC_URI="${XOOPATH}/OpenOffice_org-${XOOVER}.i586.rpm
	${XOOPATH}/OpenOffice_org-en-${XOOVER}.i586.rpm
	${XOOPATH}/OpenOffice_org-en-help-${XOOVER}.i586.rpm
	gnome? ( ${XOOPATH}/OpenOffice_org-gnome-${XOOVER}.i586.rpm )
	kde? ( ${XOOPATH}/OpenOffice_org-kde-${XOOVER}.i586.rpm )"

LICENSE="|| ( LGPL-2  SISSL-1.1 )"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="!app-office/openoffice-ximian
	virtual/x11
	virtual/libc
	>=dev-lang/perl-5.0
	gnome? ( >=x11-libs/gtk+-2.0
		>=gnome-base/gnome-vfs-2.0
		>=dev-libs/libxml2-2.0 )
	kde? ( kde-base/kdelibs )
	>=x11-libs/startup-notification-0.5
	>=media-libs/freetype-2.1.4
	media-libs/fontconfig
	app-arch/zip
	app-arch/unzip
	java? ( >=virtual/jre-1.4.1 )"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"

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
	addpredict "/root/.gnome"

	# Autoresponse file for user installation
	cat > ${T}/rsfile-local <<-"END_RS"
		[ENVIRONMENT]
		INSTALLATIONMODE=INSTALL_WORKSTATION
		INSTALLATIONTYPE=WORKSTATION
		DESTINATIONPATH=<home>/.xopenoffice/<pv>

		[JAVA]
		JavaSupport=none
	END_RS

	einfo "Installing Ximian-OpenOffice.org into build root..."
	dodir ${INSTDIR}
	cd ${S}/lib/ooo-1.1
	mv * ${D}${INSTDIR}

	#Fix for parallel install
	sed -i -e s/sversionrc/xversionrc/g ${D}${INSTDIR}/program/bootstraprc ${D}${INSTDIR}/program/instdb.ins

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

	einfo "Installing Menu shortcuts and mime info"
	cd ${WORKDIR}/opt/gnome/share/pixmaps/
	insinto /usr/share/pixmaps
	doins *.png

	cd ${WORKDIR}/opt/gnome/share/applications/
	sed -i -e s/'=oo'/'=xoo'/g *.desktop
	insinto /usr/share/applications
	doins *.desktop

	if use kde
	then
		insinto /usr/share/applnk/Ximian-OpenOffice.org
		doins *.desktop
	fi

	# Remove unneeded stuff
	rm -rf ${D}${INSTDIR}/share/cde || die

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo " To start Ximian-OpenOffice.org, run:"
	einfo
	einfo " $ xooffice"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " xoocalc, xoodraw, xooimpress, xoomath, xooweb or xoowriter"
}
