# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-3.3.0.ebuild,v 1.12 2011/03/20 15:53:22 phajdan.jr Exp $

EAPI="3"

inherit eutils fdo-mime gnome2-utils pax-utils prefix rpm multilib

IUSE="gnome java"

BUILDID="9567"
BUILDID2="9556"
MST="OOO330_m20"
MY_PV="${PV}rc10"
MY_PV2="${MY_PV}_20110118"
BVER="${PV}-${BUILDID}"
BVER2="3.3-${BUILDID2}"
UREVER="1.7.0"
BASIS="ooobasis3.3"
BASIS2="basis3.3"
NM="openoffice"
NM1="${NM}.org"
NM2="${NM1}3"
NM3="${NM2}.3"
FILEPATH="http://download.services.openoffice.org/files/extended/${MY_PV}"
if [ "${ARCH}" = "amd64" ] ; then
	XARCH="x86_64"
	PACKED="${MST}_native_packed-1"
else
	XARCH="i586"
	PACKED="${MST}_native_packed-1"
fi
UP="${PACKED}_en-US.${BUILDID}/RPMS"

DESCRIPTION="OpenOffice productivity suite."
HOMEPAGE="http://www.openoffice.org/"
SRC_URI="x86? ( http://download.services.openoffice.org/files/stable/${PV}/OOo_${PV}_Linux_x86_install-rpm_en-US.tar.gz )
	amd64? ( http://download.services.openoffice.org/files/stable/${PV}/OOo_${PV}_Linux_x86-64_install-rpm-wJRE_en-US.tar.gz  )"

LANGS="ar as ast be_BY bg bn ca ca_XV cs da de dz el en en_GB eo es et eu fi fr ga gl gu he hi hu id is it ja ka km kn ko ku lt lv mk ml mr my nb nl nn oc om or pa_IN pl pt pt_BR ro ru sh si sk sl sr sv ta te th tr ug uk uz vi zh_CN zh_TW"

for X in ${LANGS} ; do
	[[ ${X} != "en" ]] && SRC_URI="${SRC_URI} linguas_${X}? (
		x86? ( "${FILEPATH}"/OOo_${MY_PV2}_Linux_x86_langpack-rpm_${X/_/-}.tar.gz )
		amd64? ( "${FILEPATH}"/OOo_${MY_PV2}_Linux_x86-64_langpack-rpm_${X/_/-}.tar.gz ) )"
	IUSE="${IUSE} linguas_${X}"
done

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86 ~amd64-linux ~x86-linux"

RDEPEND="!app-office/libreoffice
	!app-office/openoffice
	!app-office/libreoffice-bin
	!prefix? ( sys-libs/glibc )
	app-arch/unzip
	app-arch/zip
	>=dev-lang/perl-5.0
	>=media-libs/freetype-2.1.10-r2
	x11-libs/libXaw
	x11-libs/libXinerama"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PDEPEND="java? ( >=virtual/jre-1.5 )"

RESTRICT="strip"

QA_EXECSTACK="usr/$(get_libdir)/${NM}/${BASIS2}/program/*
	usr/$(get_libdir)/${NM}/ure/lib/*"
QA_TEXTRELS="usr/$(get_libdir)/${NM}/${BASIS2}/program/libvclplug_genli.so \
	usr/$(get_libdir)/${NM}/${BASIS2}/program/python-core-2.6.1/lib/lib-dynload/_curses_panel.so \
	usr/$(get_libdir)/${NM}/${BASIS2}/program/python-core-2.6.1/lib/lib-dynload/_curses.so \
	usr/$(get_libdir)/${NM}/ure/lib/*"

src_unpack() {

	unpack ${A}

	cp "${FILESDIR}"/{50-${PN},wrapper.in} "${T}"
	eprefixify "${T}"/{50-${PN},wrapper.in}

	for i in base binfilter calc core01 core02 core03 core04 core05 core06 core07 draw graphicfilter images impress math ooofonts oooimprovement ooolinguistic pyuno testtool writer xsltfilter ; do
		rpm_unpack "./${UP}/${BASIS}-${i}-${BVER}.${XARCH}.rpm"
	done

	rpm_unpack "./${UP}/${NM2}-${BVER}.${XARCH}.rpm"
	rpm_unpack "./${UP}/${NM1}-ure-${UREVER}-${BUILDID}.${XARCH}.rpm"

	for j in base calc draw impress math writer; do
		rpm_unpack "./${UP}/${NM2}-${j}-${BVER}.${XARCH}.rpm"
	done

	rpm_unpack "./${UP}/desktop-integration/${NM3}-freedesktop-menus-${BVER2}.noarch.rpm"

	use gnome && rpm_unpack "./${UP}/${BASIS}-gnome-integration-${BVER}.${XARCH}.rpm"
	use java && rpm_unpack "./${UP}/${BASIS}-javafilter-${BVER}.${XARCH}.rpm"

	# English support installed by default
	rpm_unpack "./${UP}/${BASIS}-en-US-${BVER}.${XARCH}.rpm"
	rpm_unpack "./${UP}/${NM2}-en-US-${BVER}.${XARCH}.rpm"
	rpm_unpack "./${UP}/${NM2}-dict-en-${BVER}.${XARCH}.rpm"
	for s in base binfilter calc draw help impress math res writer ; do
		rpm_unpack "./${UP}/${BASIS}-en-US-${s}-${BVER}.${XARCH}.rpm"
	done

	# Localization
	strip-linguas ${LANGS}
	for l in ${LINGUAS}; do
		m="${l/_/-}"
		if [[ ${m} != "en" ]] ; then
			LANGDIR="${PACKED}_${m}.${BUILDID}/RPMS/"
			rpm_unpack "./${LANGDIR}/${BASIS}-${m}-${BVER}.${XARCH}.rpm"
			rpm_unpack "./${LANGDIR}/${NM2}-${m}-${BVER}.${XARCH}.rpm"
			for n in base binfilter calc draw help impress math res writer; do
				rpm_unpack "./${LANGDIR}/${BASIS}-${m}-${n}-${BVER}.${XARCH}.rpm"
			done

			for DICT_FILE in `find "./${LANGDIR}" -name "${NM2}-dict-*-${BVER}.${XARCH}.rpm"`; do
				DICT_REGEX="s/${NM2}-dict-(.*?)-${BVER}.${XARCH}.rpm/\1/"
				DICT_LOCALE=`basename "$DICT_FILE" | sed -E "${DICT_REGEX}"`
				if [[ -n "${DICT_LOCALE}" && ! -d "${WORKDIR}/opt/${NM1}/share/extensions/dict-${DICT_LOCALE}" ]] ; then
					rpm_unpack "${DICT_FILE}"
				fi
			done

		fi
	done

}

src_install () {

	INSTDIR="/usr/$(get_libdir)/${NM}"
	dodir ${INSTDIR}
	mv "${WORKDIR}"/opt/${NM1}/* "${ED}${INSTDIR}" || die
	mv "${WORKDIR}"/opt/${NM2}/* "${ED}${INSTDIR}" || die

	#Menu entries, icons and mime-types
	cd "${ED}${INSTDIR}/share/xdg/"
	for desk in base calc draw impress javafilter math printeradmin qstart startcenter writer; do
		if [ "${desk}" = "javafilter" ] ; then
			use java || { rm javafilter.desktop; continue; }
		fi
		mv ${desk}.desktop ${NM1}-${desk}.desktop
		sed -i -e s/${NM2}/ooffice/g ${NM1}-${desk}.desktop || die
		domenu ${NM1}-${desk}.desktop
	done
	insinto /usr/share
	doins -r "${WORKDIR}"/usr/share/icons
	doins -r "${WORKDIR}"/usr/share/mime

	# Make sure the permissions are right
	use prefix || fowners -R root:0 /

	# Install wrapper script
	newbin "${T}/wrapper.in" ooffice
	sed -i -e s/LIBDIR/$(get_libdir)/g "${ED}/usr/bin/ooffice" || die

	# Component symlinks
	for app in base calc draw impress math writer; do
		dosym ${INSTDIR}/program/s${app} /usr/bin/oo${app}
	done

	dosym ${INSTDIR}/program/spadmin /usr/bin/ooffice-printeradmin
	dosym ${INSTDIR}/program/soffice /usr/bin/soffice

	rm -f "${ED}${INSTDIR}/basis-link" || die
	dosym ${INSTDIR}/${BASIS2} ${INSTDIR}/basis-link

	# Change user install dir
	sed -i -e "s/.${NM1}\/3/.ooo3/g" "${ED}${INSTDIR}/program/bootstraprc" || die

	# Non-java weirdness see bug #99366
	use !java && rm -f "${ED}${INSTDIR}/ure/bin/javaldx"

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${T}/50-${PN}"

}

pkg_preinst() {

	use gnome && gnome2_icon_savelist

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	use gnome && gnome2_icon_cache_update

	pax-mark -m "${EPREFIX}"/usr/$(get_libdir)/${NM}/program/soffice.bin

}

pkg_postrm() {

	fdo-mime_desktop_database_update
	use gnome && gnome2_icon_cache_update

}
