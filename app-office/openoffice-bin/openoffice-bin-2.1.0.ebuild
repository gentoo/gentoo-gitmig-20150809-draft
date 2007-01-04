# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-2.1.0.ebuild,v 1.3 2007/01/04 16:12:12 opfer Exp $

inherit eutils fdo-mime rpm multilib

IUSE="gnome java kde"

MY_PV="${PV}rc2"
MY_PV1="${MY_PV}_20061130"
MY_PV2="${MY_PV}_20061201"
MY_PV3="${PV}-6"
PACKED="OOE680_m6_native_packed-1"
BUILDID="9095"
S="${WORKDIR}/${PACKED}_en-US.${BUILDID}/RPMS"
DESCRIPTION="OpenOffice productivity suite"

SRC_URI="mirror://openoffice/stable/${PV}/OOo_${PV}_LinuxIntel_install_en-US.tar.gz"

LANGS1="af as_IN be_BY bg bs ca cs cy da de el en en_GB"

for X in ${LANGS1} ; do
	[ ${X} != "en" ] && SRC_URI="${SRC_URI} linguas_${X}? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/${MY_PV}/OOo_${MY_PV1}_LinuxIntel_langpack_${X/_/-}.tar.gz )"
	IUSE="${IUSE} linguas_${X}"
done

LANGS2="en_ZA es et fa fi fr gu_IN he hi_IN hr hu it ja km ko lt mk ml_IN mr_IN nb nl nn nr ns or_IN pa_IN pl pt_BR ru rw sh_YU sk sl sr_CS st sv sw_TZ ta_IN te_IN tg th ti_ER tn tr ts ur_IN ve vi xh zh_CN zh_TW zu"

for Y in ${LANGS2} ; do
	[ ${Y} != "en" ] && SRC_URI="${SRC_URI} linguas_${Y}? ( http://oootranslation.services.openoffice.org/pub/OpenOffice.org/${MY_PV}/OOo_${MY_PV2}_LinuxIntel_langpack_${Y/_/-}.tar.gz )"
	IUSE="${IUSE} linguas_${Y}"
done

HOMEPAGE="http://www.openoffice.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

RDEPEND="!app-office/openoffice
	x11-libs/libXaw
	sys-libs/glibc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	>=media-libs/freetype-2.1.10-r2
	>=app-admin/eselect-oodict-20060706
	java? ( !amd64? ( >=virtual/jre-1.4 )
		amd64? ( app-emulation/emul-linux-x86-java ) )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
	linguas_zh_CN? ( >=media-fonts/arphicfonts-0.1-r2 )
	linguas_zh_TW? ( >=media-fonts/arphicfonts-0.1-r2 )"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PROVIDE="virtual/ooo"
RESTRICT="nostrip"

QA_EXECSTACK="usr/lib/openoffice/program/*"
QA_TEXTRELS="usr/lib/openoffice/program/libvclplug_gen680li.so.1.1 \
	usr/lib/openoffice/program/python-core-2.3.4/lib/lib-dynload/_curses_panel.so \
	usr/lib/openoffice/program/python-core-2.3.4/lib/lib-dynload/_curses.so"

src_unpack() {

	unpack ${A}

	for i in base calc core01 core02 core03 core03u core04 core04u core05 core05u core06 core07 core08 core09 core10 draw emailmerge impress math writer graphicfilter pyuno testtool xsltfilter ; do
		rpm_unpack ${S}/openoffice.org-${i}-${MY_PV3}.i586.rpm
	done

	rpm_unpack ${S}/desktop-integration/openoffice.org-freedesktop-menus-2.1-5.noarch.rpm

	use gnome && rpm_unpack ${S}/openoffice.org-gnome-integration-${MY_PV3}.i586.rpm
	use kde && rpm_unpack ${S}/openoffice.org-kde-integration-${MY_PV3}.i586.rpm
	use java && rpm_unpack ${S}/openoffice.org-javafilter-${MY_PV3}.i586.rpm

	strip-linguas en ${LANGS1} ${LANGS2}

	for i in ${LINGUAS}; do
		i="${i/_/-}"
		if [ ${i} != "en" ] ; then
			LANGDIR="${WORKDIR}/${PACKED}_${i}.${BUILDID}/RPMS/"
			rpm_unpack ${LANGDIR}/openoffice.org-${i}-${MY_PV3}.i586.rpm
			rpm_unpack ${LANGDIR}/openoffice.org-${i}-help-${MY_PV3}.i586.rpm
			rpm_unpack ${LANGDIR}/openoffice.org-${i}-res-${MY_PV3}.i586.rpm
		fi
	done

}

src_install () {

	#Multilib install dir magic for AMD64
	has_multilib_profile && ABI=x86
	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv ${WORKDIR}/opt/openoffice.org2.1/* ${D}${INSTDIR}

	#Menu entries, icons and mime-types
	cd ${D}${INSTDIR}/share/xdg/
	sed -i -e s/'Exec=openoffice.org-2.1-printeradmin'/'Exec=oopadmin2'/g printeradmin.desktop || die

	for desk in base calc draw impress math printeradmin writer; do
		mv ${desk}.desktop openoffice.org-2.1-${desk}.desktop
		sed -i -e s/openoffice.org-2.1/ooffice2/g openoffice.org-2.1-${desk}.desktop || die
		sed -i -e s/openofficeorg-21-${desk}/ooo-${desk}2/g openoffice.org-2.1-${desk}.desktop || die
		domenu openoffice.org-2.1-${desk}.desktop
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/usr/share/icons/gnome/48x48/apps/openofficeorg-21-${desk}.png ooo-${desk}2.png
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

	# Remove the provided dictionaries, we use our own instead
	rm -f ${D}${INSTDIR}/share/dict/ooo/*

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins ${FILESDIR}/${PV}/50-openoffice-bin

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	eselect oodict update --libdir $(get_libdir)

	[ -x /sbin/chpax ] && [ -e /usr/lib/openoffice/program/soffice.bin ] && chpax -zm /usr/lib/openoffice/program/soffice.bin

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo " $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
	einfo
	einfo " Spell checking is now provided through our own myspell-ebuilds, "
	einfo " if you want to use it, please install the correct myspell package "
	einfo " according to your language needs. "

}
