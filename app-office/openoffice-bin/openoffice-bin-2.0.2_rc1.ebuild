# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-2.0.2_rc1.ebuild,v 1.1 2006/02/16 21:45:57 suka Exp $

inherit eutils fdo-mime rpm multilib

IUSE="gnome java"

MY_PV="${PV/_/}"
MY_PV2="${MY_PV}_060213"
MY_PV3="${PV/_rc1/}-1"
S="${WORKDIR}/OOB680_m1_native_packed-1_en-US.9006/RPMS"
DESCRIPTION="OpenOffice productivity suite"

LANGPACK="OOo_${MY_PV2}_LinuxIntel_langpack"
LANGPACKPATH="http://62.156.160.56/pub/OpenOffice.org/${MY_PV}/${LANGPACK}"
LANGLOC="http://ftp.linux.cz/pub/localization/OpenOffice.org/devel/680/OOB680_m1/Build-1/OOo_OOB680_m1_native_LinuxIntel_langpacks_rpm/"
LANGSUFFIX="${MY_PV3}.i586.tar.gz"

SRC_URI="mirror://openoffice/contrib/rc/${MY_PV}/OOo_${MY_PV2}_LinuxIntel_install.tar.gz
	linguas_af? ( ${LANGPACKPATH}_af.tar.gz )
	linguas_ar? ( ${LANGLOC}/openoffice.org-ar-${LANGSUFFIX} )
	linguas_be_BY? ( ${LANGPACKPATH}_be-BY.tar.gz )
	linguas_bg? ( ${LANGPACKPATH}_bg.tar.gz )
	linguas_bn? ( ${LANGLOC}/openoffice.org-bn-${LANGSUFFIX} )
	linguas_br? ( ${LANGLOC}/openoffice.org-br-${LANGSUFFIX} )
	linguas_bs? ( ${LANGPACKPATH}_bs.tar.gz )
	linguas_ca? ( ${LANGPACKPATH}_ca.tar.gz )
	linguas_cs? ( ${LANGPACKPATH}_cs.tar.gz )
	linguas_cy? ( ${LANGPACKPATH}_cy.tar.gz )
	linguas_da? ( ${LANGPACKPATH}_da.tar.gz )
	linguas_de? ( ${LANGPACKPATH}_de.tar.gz )
	linguas_el? ( ${LANGPACKPATH}_el.tar.gz )
	linguas_en_GB? ( ${LANGPACKPATH}_en-GB.tar.gz )
	linguas_en_ZA? ( ${LANGPACKPATH}_en-ZA.tar.gz )
	linguas_es? ( ${LANGPACKPATH}_es.tar.gz )
	linguas_et? ( ${LANGPACKPATH}_et.tar.gz )
	linguas_fa? ( ${LANGLOC}/openoffice.org-fa-${LANGSUFFIX} )
	linguas_fi? ( ${LANGPACKPATH}_fi.tar.gz )
	linguas_fr? ( ${LANGPACKPATH}_fr.tar.gz )
	linguas_ga? ( ${LANGLOC}/openoffice.org-ga-${LANGSUFFIX} )
	linguas_gu_IN? ( ${LANGPACKPATH}_gu-IN.tar.gz )
	linguas_hi_IN? ( ${LANGPACKPATH}_hi-IN.tar.gz )
	linguas_hr? ( ${LANGPACKPATH}_hr.tar.gz )
	linguas_hu? ( ${LANGPACKPATH}_hu.tar.gz )
	linguas_it? ( ${LANGPACKPATH}_it.tar.gz )
	linguas_ja? ( ${LANGPACKPATH}_ja.tar.gz )
	linguas_km? ( ${LANGPACKPATH}_km.tar.gz )
	linguas_ko? ( ${LANGPACKPATH}_ko.tar.gz )
	linguas_lo? ( ${LANGLOC}/openoffice.org-lo-${LANGSUFFIX} )
	linguas_lt? ( ${LANGPACKPATH}_lt.tar.gz )
	linguas_lv? ( ${LANGLOC}/openoffice.org-lv-${LANGSUFFIX} )
	linguas_mk? ( ${LANGPACKPATH}_mk.tar.gz )
	linguas_nb? ( ${LANGPACKPATH}_nb.tar.gz )
	linguas_ne? ( ${LANGLOC}/openoffice.org-ne-${LANGSUFFIX} )
	linguas_nl? ( ${LANGPACKPATH}_nl.tar.gz )
	linguas_nn? ( ${LANGPACKPATH}_nn.tar.gz )
	linguas_nr? ( ${LANGLOC}/openoffice.org-nr-${LANGSUFFIX} )
	linguas_ns? ( ${LANGPACKPATH}_ns.tar.gz )
	linguas_pa_IN? ( ${LANGPACKPATH}_pa-IN.tar.gz )
	linguas_pl? ( ${LANGPACKPATH}_pl.tar.gz )
	linguas_pt_BR? ( ${LANGPACKPATH}_pt-BR.tar.gz )
	linguas_ru? ( ${LANGPACKPATH}_ru.tar.gz )
	linguas_rw? ( ${LANGPACKPATH}_rw.tar.gz )
	linguas_sh_YU? ( ${LANGPACKPATH}_sh-YU.tar.gz )
	linguas_sk? ( ${LANGPACKPATH}_sk.tar.gz )
	linguas_sl? ( ${LANGPACKPATH}_sl.tar.gz )
	linguas_sr_CS? ( ${LANGPACKPATH}_sr-CS.tar.gz )
	linguas_st? ( ${LANGPACKPATH}_st.tar.gz )
	linguas_sv? ( ${LANGPACKPATH}_sv.tar.gz )
	linguas_sw_TZ? ( ${LANGPACKPATH}_sw-TZ.tar.gz )
	linguas_th? ( ${LANGPACKPATH}_th.tar.gz )
	linguas_tn? ( ${LANGLOC}/openoffice.org-tn-${LANGSUFFIX} )
	linguas_tr? ( ${LANGPACKPATH}_tr.tar.gz )
	linguas_ts? ( ${LANGLOC}/openoffice.org-ts-${LANGSUFFIX} )
	linguas_vi? ( ${LANGPACKPATH}_vi.tar.gz )
	linguas_xh? ( ${LANGLOC}/openoffice.org-xh-${LANGSUFFIX} )
	linguas_zh_CN? ( ${LANGPACKPATH}_zh-CN.tar.gz )
	linguas_zh_TW? ( ${LANGPACKPATH}_zh-TW.tar.gz )
	linguas_zu? ( ${LANGPACKPATH}_zu.tar.gz )"

HOMEPAGE="http://www.openoffice.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="!app-office/openoffice
	|| ( x11-libs/libXaw virtual/x11 )
	sys-libs/glibc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	java? ( !amd64? ( >=virtual/jre-1.4.1 )
		amd64? ( app-emulation/emul-linux-x86-java ) )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
	linguas_zh_CN? ( >=media-fonts/arphicfonts-0.1-r2 )
	linguas_zh_TW? ( >=media-fonts/arphicfonts-0.1-r2 )"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"

src_unpack() {

	unpack ${A}

	for i in base calc core01 core02 core03 core03u core04 core04u core05 core05u core06 core07 core08 core09 core10 draw emailmerge impress math writer graphicfilter pyuno spellcheck testtool xsltfilter ; do
		rpm_unpack ${S}/openoffice.org-${i}-${MY_PV3}.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openoffice.org-freedesktop-menus-2.0.2-0.noarch.rpm

	use gnome && rpm_unpack ${S}/openoffice.org-gnome-integration-${MY_PV3}.i586.rpm
	use java && rpm_unpack ${S}/openoffice.org-javafilter-${MY_PV3}.i586.rpm

	strip-linguas en af ar be_BY bg bn br bs ca cs cy da de el en_GB en_ZA es et fa fi fr ga gu_IN hi_IN hr hu it ja km ko lo lt lv mk nb ne nl nn nr ns pa_IN pl pt_BR ru rw sh_YU sk sl sr_CS st sv sw_TZ th tn tr ts vi xh zh_CN zh_TW zu

	for i in ${LINGUAS}; do
		i="${i/_/-}"

		#workaround for upstream packaging mismatch
		if [ -d ${WORKDIR}/OOB680_m1_native_packed-1_${i}.9006 ] ; then
			 tar -xzf ${WORKDIR}/OOB680_m1_native_packed-1_${i}.9006/RPMS/openoffice.org-${i}-${LANGSUFFIX} || die
		fi

		if [ ${i} != "en" ] ; then
			rpm_unpack openoffice.org-${i}-${MY_PV3}.i586.rpm
			rpm_unpack openoffice.org-${i}-help-${MY_PV3}.i586.rpm
			rpm_unpack openoffice.org-${i}-res-${MY_PV3}.i586.rpm
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

	[ -x /sbin/chpax ] && [ -e /usr/lib/openoffice/program/soffice.bin ] && chpax -zm /usr/lib/openoffice/program/soffice.bin

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo "   $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
}
