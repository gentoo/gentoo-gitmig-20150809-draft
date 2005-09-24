# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-1.9.130.ebuild,v 1.3 2005/09/24 07:24:37 suka Exp $

inherit eutils fdo-mime rpm versionator

IUSE="gnome java kde"

INSTDIR="/usr/lib/openoffice"
SNV="$(get_version_component_range 3)"
S="${WORKDIR}/SRC680_m${SNV}_native_packed-1_en-US.8955/RPMS"
DESCRIPTION="OpenOffice productivity suite"

LANGPACK="OOo_${PV}_LinuxIntel_langpack"
LANGPACKPATH="http://oootranslation.services.openoffice.org/pub/OpenOffice.org/680m${SNV}/${LANGPACK}"
LANGLOC="http://ftp.linux.cz/pub/localization/OpenOffice.org/devel/680/SRC680_m${SNV}/Build-1/OOo_SRC680_m${SNV}_native_LinuxIntel_langpacks_rpm"
LANGSUFFIX="${PV}-1.i586.tar.gz"

SRC_URI="mirror://openoffice/developer/680_m${SNV}/OOo_${PV}_LinuxIntel_install.tar.gz
	linguas_af? ( ${LANGLOC}/openoffice.org-af-${LANGSUFFIX} )
	linguas_bg? ( ${LANGLOC}/openoffice.org-bg-${LANGSUFFIX} )
	linguas_bn? ( ${LANGLOC}/openoffice.org-bn-${LANGSUFFIX} )
	linguas_br? ( ${LANGLOC}/openoffice.org-br-${LANGSUFFIX} )
	linguas_cs? ( ${LANGLOC}/openoffice.org-cs-${LANGSUFFIX} )
	linguas_cy? ( ${LANGLOC}/openoffice.org-cy-${LANGSUFFIX} )
	linguas_da? ( ${LANGLOC}/openoffice.org-da-${LANGSUFFIX} )
	linguas_de? ( ${LANGLOC}/openoffice.org-de-${LANGSUFFIX} )
	linguas_en_GB? ( ${LANGLOC}/openoffice.org-en-GB-${LANGSUFFIX} )
	linguas_et? ( ${LANGLOC}/openoffice.org-et-${LANGSUFFIX} )
	linguas_fi? ( ${LANGLOC}/openoffice.org-fi-${LANGSUFFIX} )
	linguas_fr? ( ${LANGLOC}/openoffice.org-fr-${LANGSUFFIX} )
	linguas_ga? ( ${LANGLOC}/openoffice.org-ga-${LANGSUFFIX} )
	linguas_hr? ( ${LANGLOC}/openoffice.org-hr-${LANGSUFFIX} )
	linguas_hu? ( ${LANGLOC}/openoffice.org-hu-${LANGSUFFIX} )
	linguas_it? ( ${LANGLOC}/openoffice.org-it-${LANGSUFFIX} )
	linguas_km? ( ${LANGLOC}/openoffice.org-km-${LANGSUFFIX} )
	linguas_lt? ( ${LANGLOC}/openoffice.org-lt-${LANGSUFFIX} )
	linguas_nb? ( ${LANGLOC}/openoffice.org-nb-${LANGSUFFIX} )
	linguas_ne? ( ${LANGLOC}/openoffice.org-ne-${LANGSUFFIX} )
	linguas_nl? ( ${LANGLOC}/openoffice.org-nl-${LANGSUFFIX} )
	linguas_nn? ( ${LANGLOC}/openoffice.org-nn-${LANGSUFFIX} )
	linguas_ns? ( ${LANGLOC}/openoffice.org-ns-${LANGSUFFIX} )
	linguas_sh_YU? ( ${LANGLOC}/openoffice.org-sh-YU-${LANGSUFFIX} )
	linguas_sk? ( ${LANGLOC}/openoffice.org-sk-${LANGSUFFIX} )
	linguas_sl? ( ${LANGLOC}/openoffice.org-sl-${LANGSUFFIX} )
	linguas_sr_CS? ( ${LANGLOC}/openoffice.org-sr-CS-${LANGSUFFIX} )
	linguas_sv? ( ${LANGLOC}/openoffice.org-sv-${LANGSUFFIX} )
	linguas_tn? ( ${LANGLOC}/openoffice.org-tn-${LANGSUFFIX} )
	linguas_xh? ( ${LANGLOC}/openoffice.org-xh-${LANGSUFFIX} )
	linguas_zu? ( ${LANGLOC}/openoffice.org-zu-${LANGSUFFIX} )"

HOMEPAGE="http://www.openoffice.org/"

LICENSE="LGPL-2"
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

	unpack ${A}

	for i in base core01 core02 core03 core04 core05 core06 core07 core08 core09 core10 calc draw impress math writer graphicfilter pyuno spellcheck testtool xsltfilter core03u core04u core05u ; do
		rpm_unpack ${S}/openoffice.org-${i}-${PV}-1.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openoffice.org-freedesktop-menus-${PV}-1.noarch.rpm
	use kde && rpm_unpack ${S}/desktop-integration/openoffice.org-suse-menus-${PV}-1.noarch.rpm

	use gnome && rpm_unpack ${S}/openoffice.org-gnome-integration-${PV}-1.i586.rpm
	use java && rpm_unpack ${S}/openoffice.org-javafilter-${PV}-1.i586.rpm

	strip-linguas en af bg bn br cs cy da de en_GB et fi fr ga hr hu it km lt nb ne nl nn ns sh_YU sk sl sr_CS sv tn xh zu

	for i in ${LINGUAS}; do
		i="${i/_/-}"
		if [ ${i} != "en" ] ; then
			rpm_unpack openoffice.org-${i}-${PV}-1.i586.rpm
			rpm_unpack openoffice.org-${i}-help-${PV}-1.i586.rpm
			rpm_unpack openoffice.org-${i}-res-${PV}-1.i586.rpm
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

	# Fixing some icon dir permissions
	chmod +r -R ${D}/usr/share/icons/ || die

	# Non-java weirdness see bug #99366
	use java || rm -f ${D}${INSTDIR}/program/javaldx
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
