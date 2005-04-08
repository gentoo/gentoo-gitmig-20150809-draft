# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.9.91-r1.ebuild,v 1.1 2005/04/08 20:56:48 suka Exp $

inherit eutils fdo-mime rpm versionator

IUSE="gnome java kde"

INSTDIR="/opt/OpenOffice.org"

S="${WORKDIR}/RPMS"
DESCRIPTION="OpenOffice productivity suite"

SNV="$(get_version_component_range 3)"
LANGPACK="OOo_1.9.m${SNV}_LinuxIntel_langpack"

SRC_URI="mirror://openoffice/developer/680_m${SNV}/OOo_1.9.${SNV}_LinuxIntel_install.tar.gz
	linguas_de? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_de.sh )
	linguas_es? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_es.sh )
	linguas_fr? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_fr.sh )
	linguas_it? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_it.sh )
	linguas_ja? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_ja.sh )
	linguas_ko? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_ko.sh )
	linguas_pt_BR? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_pt-BR.sh )
	linguas_sv? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_sv.sh )
	linguas_zh_CN? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_zh-CN.sh )
	linguas_zh_TW? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_zh-TW.sh )"

HOMEPAGE="http://www.openoffice.org/"

LICENSE="|| ( LGPL-2  SISSL-1.1 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="!app-office/openoffice
	virtual/x11
	virtual/libc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	java? ( >=virtual/jre-1.4.1 )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
	linguas_zh_CN? ( >=media-fonts/arphicfonts-0.1-r2 )
	linguas_zh_TW? ( >=media-fonts/arphicfonts-0.1-r2 )"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"

src_unpack() {
	unpack OOo_1.9.${SNV}_LinuxIntel_install.tar.gz

	for i in core01 core02 core03 core04 core05 core06 core07 core08 calc draw impress math writer graphicfilter pyuno spellcheck testtool xsltfilter; do
		rpm_unpack ${S}/openofficeorg-${i}-1.9.${SNV}-1.i586.rpm
	done

	rpm_unpack ${S}/openofficeorg-freedesktop-menus-1.9.${SNV}-1.noarch.rpm
	use kde && rpm_unpack ${S}/openofficeorg-suse-menus-1.9.${SNV}-1.noarch.rpm

	use gnome && rpm_unpack ${S}/openofficeorg-gnome-integration-1.9.${SNV}-1.i586.rpm
	use java && rpm_unpack ${S}/openofficeorg-javafilter-1.9.${SNV}-1.i586.rpm

	strip-linguas en de es fr it ja ko pt_BR sv zh_CN zh_TW

	export LINGUAS_OOO="${LINGUAS/en}"

	for i in ${LINGUAS_OOO}; do
		i="${i/_/-}"
		cp /usr/portage/distfiles/${LANGPACK}_${i}.sh ${S} || die
		tail -n +146 ${S}/${LANGPACK}_${i}.sh > ${S}/${LANGPACK}_${i}.rpm || die
		rpm_unpack ${S}/${LANGPACK}_${i}.rpm
	done
}

src_install () {
	# Sandbox issues; bug #8587
	addpredict "/user"
	addpredict "/share"
	addpredict "/dev/dri"
	addpredict "/usr/bin/soffice"
	addpredict "/pspfontcache"
	addpredict "/root/.gconfd"
	addpredict "/opt/OpenOffice.org/foo.tmp"
	addpredict "/opt/OpenOffice.org/delme"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	dodir /usr/share/icons
	dodir /usr/share/mime
	mv ${WORKDIR}/opt/openoffice.org1.9.${SNV}/* ${D}${INSTDIR}
	mv ${WORKDIR}/usr/share/icons/* ${D}/usr/share/icons
	mv ${WORKDIR}/usr/share/mime/* ${D}/usr/share/mime

	use kde && dodir /usr/share/mimelnk/application && mv ${WORKDIR}/opt/kde3/share/mimelnk/application/* ${D}/usr/share/mimelnk/application

	#Menu entries
	cd ${D}${INSTDIR}/share/xdg/

	sed -i -e s/'Exec=openoffice.org-1.9-printeradmin'/'Exec=oopadmin'/g printeradmin.desktop

	for desk in base calc draw impress math writer printeradmin; do
		mv ${desk}.desktop openoffice.org-1.9-${desk}.desktop
		domenu openoffice.org-1.9-${desk}.desktop
	done

	einfo "Removing build root from registry..."
	# Install wrapper script
	newbin ${FILESDIR}/1.9/ooffice-wrapper-1.9 openoffice.org-1.9

	# Component symlinks
	for app in calc draw impress math writer web padmin; do
		dosym openoffice.org-1.9 /usr/bin/oo${app}
	done

	dosym openoffice.org-1.9 /usr/bin/openoffice.org-1.9-printeradmin
}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ openoffice.org-1.9"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo "   oocalc, oodraw, ooimpress, oomath, ooweb or oowriter"
}
