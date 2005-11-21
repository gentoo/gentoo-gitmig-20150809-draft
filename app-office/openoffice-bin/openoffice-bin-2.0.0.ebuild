# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-2.0.0.ebuild,v 1.4 2005/11/21 15:06:37 suka Exp $

inherit eutils fdo-mime rpm multilib

IUSE="gnome java"

MY_PV="${PV}rc2"
MY_PV2="${MY_PV}_051005"
S="${WORKDIR}/OOO680_m3_native_packed-2_en-US.8968/RPMS"
DESCRIPTION="OpenOffice productivity suite"

LANGPACK="OOo_${MY_PV2}_LinuxIntel_langpack"
LANGPACKPATH="http://oootranslation.services.openoffice.org/pub/OpenOffice.org/${MY_PV}/${LANGPACK}"
LANGLOC="http://ftp.linux.cz/pub/localization/OpenOffice.org/devel/680/OOO680_m3/Build-1/OOo_OOO680_m3_native_LinuxIntel_langpacks_rpm"
LANGSUFFIX="${PV}-3.i586.tar.gz"

SRC_URI="mirror://openoffice/stable/${PV}/OOo_${PV}_LinuxIntel_install.tar.gz
	linguas_af? ( ${LANGLOC}/openoffice.org-af-${LANGSUFFIX} )
	linguas_be_BY? ( ${LANGPACKPATH}_be-BY.tar.gz )
	linguas_bg? ( ${LANGPACKPATH}_bg.tar.gz )
	linguas_bn? ( ${LANGLOC}/openoffice.org-bn-${LANGSUFFIX} )
	linguas_br? ( ${LANGLOC}/openoffice.org-br-${LANGSUFFIX} )
	linguas_ca? ( ${LANGPACKPATH}_ca.tar.gz )
	linguas_cs? ( ${LANGPACKPATH}_cs.tar.gz )
	linguas_cy? ( ${LANGPACKPATH}_cy.tar.gz )
	linguas_da? ( ${LANGPACKPATH}_da.tar.gz )
	linguas_de? ( ${LANGPACKPATH}_de.tar.gz )
	linguas_el? ( ${LANGPACKPATH}_el.tar.gz )
	linguas_en_GB? ( ${LANGLOC}/openoffice.org-en-GB-${LANGSUFFIX} )
	linguas_es? ( ${LANGPACKPATH}_es.tar.gz )
	linguas_et? ( ${LANGPACKPATH}_et.tar.gz )
	linguas_fi? ( ${LANGPACKPATH}_fi.tar.gz )
	linguas_fr? ( ${LANGPACKPATH}_fr.tar.gz )
	linguas_ga? ( ${LANGLOC}/openoffice.org-ga-${LANGSUFFIX} )
	linguas_gu_IN? ( ${LANGPACKPATH}_gu-IN.tar.gz )
	linguas_hr? ( ${LANGPACKPATH}_hr.tar.gz )
	linguas_hu? ( ${LANGPACKPATH}_hu.tar.gz )
	linguas_it? ( ${LANGLOC}/openoffice.org-it-${LANGSUFFIX} )
	linguas_ja? ( ${LANGPACKPATH}_ja.tar.gz )
	linguas_km? ( ${LANGPACKPATH}_km.tar.gz )
	linguas_ko? ( ${LANGPACKPATH}_ko.tar.gz )
	linguas_lt? ( ${LANGLOC}/openoffice.org-lt-${LANGSUFFIX} )
	linguas_lv? ( ${LANGLOC}/openoffice.org-lv-${LANGSUFFIX} )
	linguas_mk? ( ${LANGLOC}/openoffice.org-mk-${LANGSUFFIX} )
	linguas_nb? ( ${LANGLOC}/openoffice.org-nb-${LANGSUFFIX} )
	linguas_ne? ( ${LANGLOC}/openoffice.org-ne-${LANGSUFFIX} )
	linguas_nl? ( ${LANGPACKPATH}_nl.tar.gz )
	linguas_nn? ( ${LANGPACKPATH}_nn.tar.gz )
	linguas_ns? ( ${LANGLOC}/openoffice.org-ns-${LANGSUFFIX} )
	linguas_pa_IN? ( ${LANGPACKPATH}_pa-IN.tar.gz )
	linguas_pl? ( ${LANGPACKPATH}_pl.tar.gz )
	linguas_pt_BR? ( ${LANGPACKPATH}_pt-BR.tar.gz )
	linguas_ru? ( ${LANGPACKPATH}_ru.tar.gz )
	linguas_rw? ( ${LANGPACKPATH}_rw.tar.gz )
	linguas_sh_YU? ( ${LANGPACKPATH}_sh-YU.tar.gz )
	linguas_sk? ( ${LANGPACKPATH}_sk.tar.gz )
	linguas_sl? ( ${LANGLOC}/openoffice.org-sl-${LANGSUFFIX} )
	linguas_sr_CS? ( ${LANGPACKPATH}_sr-CS.tar.gz )
	linguas_sv? ( ${LANGLOC}/openoffice.org-sv-${LANGSUFFIX} )
	linguas_sw_TZ? ( ${LANGPACKPATH}_sw-TZ.tar.gz )
	linguas_tn? ( ${LANGLOC}/openoffice.org-tn-${LANGSUFFIX} )
	linguas_tr? ( ${LANGPACKPATH}_tr.tar.gz )
	linguas_vi? ( ${LANGPACKPATH}_vi.tar.gz )
	linguas_xh? ( ${LANGLOC}/openoffice.org-xh-${LANGSUFFIX} )
	linguas_zh_CN? ( ${LANGPACKPATH}_zh-CN.tar.gz )
	linguas_zh_TW? ( ${LANGPACKPATH}_zh-TW.tar.gz )
	linguas_zu? ( ${LANGLOC}/openoffice.org-zu-${LANGSUFFIX} )"

HOMEPAGE="http://www.openoffice.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="!app-office/openoffice
	virtual/x11
	sys-libs/glibc
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

	unpack ${A}

	for i in base calc core01 core02 core03 core03u core04 core04u core05 core05u core06 core07 core08 core09 core10 draw impress math writer graphicfilter pyuno spellcheck testtool xsltfilter ; do
		rpm_unpack ${S}/openoffice.org-${i}-${PV}-3.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openoffice.org-freedesktop-menus-${PV}-3.noarch.rpm

	use gnome && rpm_unpack ${S}/openoffice.org-gnome-integration-${PV}-3.i586.rpm
	use java && rpm_unpack ${S}/openoffice.org-javafilter-${PV}-3.i586.rpm

	strip-linguas en af be_BY bg bn br ca cs cy da de el en_GB es et fi fr ga gu_IN hr hu it ja km ko lt lv mk nb ne nl nn ns pa_IN pl pt_BR ru rw sh_YU sk sl sr_CS sv sw_TZ tn tr vi xh zh_CN zh_TW zu

	for i in ${LINGUAS}; do
		i="${i/_/-}"
		if [ ${i} != "en" ] ; then
			rpm_unpack openoffice.org-${i}-${PV}-*.i586.rpm
			rpm_unpack openoffice.org-${i}-help-${PV}-*.i586.rpm
			rpm_unpack openoffice.org-${i}-res-${PV}-*.i586.rpm
		fi
	done

}

src_install () {

	#Multilib install dir magic for AMD64
	has_multilib_profile && ABI=x86
	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv ${WORKDIR}/opt/openoffice.org2.0/* ${D}${INSTDIR}

	#Menu entries, icons and mime-types
	cd ${D}${INSTDIR}/share/xdg/
	sed -i -e s/'Exec=openoffice.org-2.0-printeradmin'/'Exec=oopadmin2'/g printeradmin.desktop || die

	for desk in base calc draw impress math printeradmin writer; do
		mv ${desk}.desktop openoffice.org-2.0-${desk}.desktop
		sed -i -e s/openoffice.org-2.0/ooffice2/g openoffice.org-2.0-${desk}.desktop || die
		sed -i -e s/openofficeorg-20-${desk}/ooo-${desk}2/g openoffice.org-2.0-${desk}.desktop || die
		domenu openoffice.org-2.0-${desk}.desktop
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/usr/share/icons/gnome/48x48/apps/openofficeorg-20-${desk}.png ooo-${desk}2.png
	done

	insinto /usr/share/mime/packages
	doins ${WORKDIR}/usr/share/mime/packages/openoffice.org.xml

	# Install wrapper script
	newbin ${FILESDIR}/${PV}/ooo-wrapper2 ooffice2
	sed -i -e s/PV/${PV}/g ${D}/usr/bin/ooffice2 || die
	sed -i -e "s|INSTDIR|${INSTDIR}|g" ${D}/usr/bin/ooffice2 || die

	# Component symlinks
	for app in base calc draw fromtemplate impress math web writer; do
		dosym ooffice2 /usr/bin/oo${app}2
	done

	dosym ${INSTDIR}/program/spadmin.bin /usr/bin/oopadmin2

	# Change user install dir
	sed -i -e s/.openoffice.org2/.ooo-2.0/g ${D}${INSTDIR}/program/bootstraprc || die

	# Non-java weirdness see bug #99366
	use !java && rm -f ${D}${INSTDIR}/program/javaldx
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
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
}
