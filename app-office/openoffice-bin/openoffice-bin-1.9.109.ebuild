# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.9.109.ebuild,v 1.1 2005/06/16 16:48:15 suka Exp $

inherit eutils fdo-mime rpm versionator

IUSE="gnome java kde"

INSTDIR="/opt/OpenOffice.org"

S="${WORKDIR}/RPMS"
DESCRIPTION="OpenOffice productivity suite"

SNV="$(get_version_component_range 3)"
LANGPACK="OOo_${PV}_LinuxIntel_langpack"
LANGPACKPATH="http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}"
LANGLOC="http://ftp.linux.cz/pub/localization/OpenOffice.org/devel/680/SRC680_m${SNV}/Build-1/OOo_SRC680_m${SNV}_native_LinuxIntel_langpacks_rpm"
LANGSUFFIX="${PV}-1.i586.tar.gz"

SRC_URI="mirror://openoffice/developer/680_m${SNV}/OOo_${PV}_LinuxIntel_install.tar.gz
	linguas_af? ( ${LANGLOC}/openofficeorg-af-${LANGSUFFIX} )
	linguas_bg? ( ${LANGLOC}/openofficeorg-bg-${LANGSUFFIX} )
	linguas_cs? ( ${LANGLOC}/openofficeorg-cs-${LANGSUFFIX} )
	linguas_cy? ( ${LANGLOC}/openofficeorg-cy-${LANGSUFFIX} )
	linguas_da? ( ${LANGLOC}/openofficeorg-da-${LANGSUFFIX} )
	linguas_de? ( ${LANGLOC}/openofficeorg-de-${LANGSUFFIX} )
	linguas_en_GB? ( ${LANGLOC}/openofficeorg-en-GB-${LANGSUFFIX} )
	linguas_es? ( ${LANGPACKPATH}_es.sh )
	linguas_et? ( ${LANGLOC}/openofficeorg-et-${LANGSUFFIX} )
	linguas_fi? ( ${LANGLOC}/openofficeorg-fi-${LANGSUFFIX} )
	linguas_fr? ( ${LANGLOC}/openofficeorg-fr-${LANGSUFFIX} )
	linguas_hr? ( ${LANGLOC}/openofficeorg-hr-${LANGSUFFIX} )
	linguas_hu? ( ${LANGLOC}/openofficeorg-hu-${LANGSUFFIX} )
	linguas_it? ( ${LANGPACKPATH}_it.sh )
	linguas_ja? ( ${LANGPACKPATH}_ja.sh )
	linguas_km? ( ${LANGLOC}/openofficeorg-km-${LANGSUFFIX} )
	linguas_ko? ( ${LANGPACKPATH}_ko.sh )
	linguas_lt? ( ${LANGLOC}/openofficeorg-lt-${LANGSUFFIX} )
	linguas_nb? ( ${LANGLOC}/openofficeorg-nb-${LANGSUFFIX} )
	linguas_nl? ( ${LANGLOC}/openofficeorg-nl-${LANGSUFFIX} )
	linguas_nn? ( ${LANGLOC}/openofficeorg-nn-${LANGSUFFIX} )
	linguas_ns? ( ${LANGLOC}/openofficeorg-ns-${LANGSUFFIX} )
	linguas_pt_BR? ( ${LANGPACKPATH}_pt-BR.sh )
	linguas_sk? ( ${LANGLOC}/openofficeorg-sk-${LANGSUFFIX} )
	linguas_sl? ( ${LANGLOC}/openofficeorg-sl-${LANGSUFFIX} )
	linguas_sv? ( ${LANGPACKPATH}_sv.sh )
	linguas_tn? ( ${LANGLOC}/openofficeorg-tn-${LANGSUFFIX} )
	linguas_xh? ( ${LANGLOC}/openofficeorg-xh-${LANGSUFFIX} )
	linguas_zh_CN? ( ${LANGPACKPATH}_zh-CN.sh )
	linguas_zh_TW? ( ${LANGPACKPATH}_zh-TW.sh )
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
	unpack OOo_${PV}_LinuxIntel_install.tar.gz

	for i in core01 core02 core03 core04 core05 core06 core07 core08 core09 core10 calc draw impress math writer graphicfilter pyuno spellcheck testtool xsltfilter core03u core04u core05u ; do
		rpm_unpack ${S}/openofficeorg-${i}-${PV}-1.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openofficeorg-freedesktop-menus-${PV}-1.noarch.rpm
	use kde && rpm_unpack ${S}/desktop-integration/openofficeorg-suse-menus-${PV}-1.noarch.rpm

	use gnome && rpm_unpack ${S}/openofficeorg-gnome-integration-${PV}-1.i586.rpm
	use java && rpm_unpack ${S}/openofficeorg-javafilter-${PV}-1.i586.rpm

	strip-linguas en af bg cs cy da de en_GB es et fi fr hr hu it ja km ko lt nb nl nn ns pt_BR sk sl sv tn xh zh_CN zh_TW zu

	for i in ${LINGUAS}; do
		i="${i/_/-}"
		if [ ${i} != "en" ] ; then
			if [ -e ${DISTDIR}/${LANGPACK}_${i}.sh ] ; then
				tail -n +159 ${DISTDIR}/${LANGPACK}_${i}.sh > ${S}/${LANGPACK}_${i}.tar.gz || die
				tar -xvf ${S}/${LANGPACK}_${i}.tar.gz || die
			else
				unpack openofficeorg-${i}-${LANGSUFFIX}
			fi
			rpm_unpack openofficeorg-${i}-${PV}-1.i586.rpm
			rpm_unpack openofficeorg-${i}-help-${PV}-1.i586.rpm
			rpm_unpack openofficeorg-${i}-res-${PV}-1.i586.rpm
		fi
	done
}

src_install () {

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	dodir /usr/share/icons
	dodir /usr/share/mime
	mv ${WORKDIR}/opt/openoffice.org${PV}/* ${D}${INSTDIR}
	mv ${WORKDIR}/usr/share/icons/* ${D}/usr/share/icons

	use kde && dodir /usr/share/mimelnk/application && mv ${WORKDIR}/opt/kde3/share/mimelnk/application/* ${D}/usr/share/mimelnk/application

	#Menu entries
	cd ${D}${INSTDIR}/share/xdg/

	sed -i -e s/'Exec=openoffice.org-1.9-printeradmin'/'Exec=oopadmin2'/g printeradmin.desktop || die

	for desk in base calc draw impress math writer printeradmin; do
		mv ${desk}.desktop openoffice.org-1.9-${desk}.desktop
		sed -i -e s/openoffice.org-1.9/ooffice2/g openoffice.org-1.9-${desk}.desktop || die
		domenu openoffice.org-1.9-${desk}.desktop
	done

	# Install wrapper script
	newbin ${FILESDIR}/1.9/ooo-wrapper2 ooffice2
	sed -i -e s/PV/${PV}/g ${D}/usr/bin/ooffice2 || die

	# Component symlinks
	for app in base calc draw fromtemplate impress math web writer; do
		dosym ooffice2 /usr/bin/oo${app}2
	done

	dosym ${INSTDIR}/program/spadmin.bin /usr/bin/oopadmin2

	# Change user install dir
	sed -i -e s/.openoffice.org${PV}/.ooo-2.0-pre/g ${D}${INSTDIR}/program/bootstraprc || die
}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oocalc2, oodraw2, ooimpress2, oomath2, ooweb2 or oowriter2"
}
