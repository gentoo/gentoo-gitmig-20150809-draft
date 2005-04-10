# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.9.91-r2.ebuild,v 1.1 2005/04/10 15:15:48 suka Exp $

inherit eutils fdo-mime rpm versionator

IUSE="gnome java kde"

INSTDIR="/opt/OpenOffice.org"

S="${WORKDIR}/RPMS"
DESCRIPTION="OpenOffice productivity suite"

SNV="$(get_version_component_range 3)"
LANGPACK="OOo_1.9.m${SNV}_LinuxIntel_langpack"
LANGLOC="http://ftp.linux.cz/pub/localization/OpenOffice.org/devel/680/SRC680_m${SNV}/Build-1/OOo_SRC680_m${SNV}_native_LinuxIntel_langpacks_rpm"
LANGSUFFIX="1.9.${SNV}-1.i586.rpm"

SRC_URI="mirror://openoffice/developer/680_m${SNV}/OOo_1.9.${SNV}_LinuxIntel_install.tar.gz
	linguas_af? ( ${LANGLOC}/openofficeorg-af-${LANGSUFFIX} )
	linguas_bg? ( ${LANGLOC}/openofficeorg-bg-${LANGSUFFIX} )
	linguas_cs? ( ${LANGLOC}/openofficeorg-cs-${LANGSUFFIX} )
	linguas_cy? ( ${LANGLOC}/openofficeorg-cy-${LANGSUFFIX} )
	linguas_da? ( ${LANGLOC}/openofficeorg-da-${LANGSUFFIX} )
	linguas_de? ( ${LANGLOC}/openofficeorg-de-${LANGSUFFIX} )
	linguas_en_GB? ( ${LANGLOC}/openofficeorg-en-GB-${LANGSUFFIX} )
	linguas_es? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_es.sh )
	linguas_et? ( ${LANGLOC}/openofficeorg-et-${LANGSUFFIX} )
	linguas_fi? ( ${LANGLOC}/openofficeorg-fi-${LANGSUFFIX} )
	linguas_fr? ( ${LANGLOC}/openofficeorg-fr-${LANGSUFFIX} )
	linguas_hu? ( ${LANGLOC}/openofficeorg-hu-${LANGSUFFIX} )
	linguas_it? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_it.sh )
	linguas_ja? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_ja.sh )
	linguas_km? ( ${LANGLOC}/openofficeorg-km-${LANGSUFFIX} )
	linguas_ko? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_ko.sh )
	linguas_nb? ( ${LANGLOC}/openofficeorg-nb-${LANGSUFFIX} )
	linguas_nl? ( ${LANGLOC}/openofficeorg-nl-${LANGSUFFIX} )
	linguas_nn? ( ${LANGLOC}/openofficeorg-nn-${LANGSUFFIX} )
	linguas_ns? ( ${LANGLOC}/openofficeorg-ns-${LANGSUFFIX} )
	linguas_pt_BR? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_pt-BR.sh )
	linguas_sk? ( ${LANGLOC}/openofficeorg-sk-${LANGSUFFIX} )
	linguas_sl? ( ${LANGLOC}/openofficeorg-sl-${LANGSUFFIX} )
	linguas_sv? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_sv.sh )
	linguas_tn? ( ${LANGLOC}/openofficeorg-tn-${LANGSUFFIX} )
	linguas_xh? ( ${LANGLOC}/openofficeorg-xh-${LANGSUFFIX} )
	linguas_zh_CN? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_zh-CN.sh )
	linguas_zh_TW? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}_zh-TW.sh )
	linguas_zu? ( ${LANGLOC}/openofficeorg-zu-${LANGSUFFIX} )"

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

	strip-linguas en af bg cs cy da de en_GB es et fi fr hu it ja km ko nb nl nn ns pt_BR sk sl sv tn xh zh_CN zh_TW zu

	export LINGUAS_OOO="${LINGUAS/en}"

	for i in ${LINGUAS_OOO}; do
		i="${i/_/-}"
		if [ -e ${DISTDIR}/${LANGPACK}_${i}.sh ] ; then
			tail -n +146 ${DISTDIR}/${LANGPACK}_${i}.sh > ${S}/${LANGPACK}_${i}.rpm || die
			rpm_unpack ${S}/${LANGPACK}_${i}.rpm
		else
			rpm_unpack ${DISTDIR}/openofficeorg-${i}-${LANGSUFFIX}
		fi
done
}

src_install () {

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
