# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-3.3.0.ebuild,v 1.6 2011/03/17 13:51:00 suka Exp $

EAPI="3"

inherit eutils fdo-mime gnome2-utils pax-utils prefix rpm multilib

IUSE="gnome java"

BUILDID="9567"
BUILDID2="9556"
UREVER="1.7.0"
MY_PV="${PV}rc10"
MY_PV2="${MY_PV}_20110118"
MY_PV3="${PV}-${BUILDID}"
BASIS="ooobasis3.3"
MST="OOO330_m20"
FILEPATH="http://download.services.openoffice.org/files/extended/${MY_PV}"

if [ "${ARCH}" = "amd64" ] ; then
	OOARCH="x86_64"
	PACKED="${MST}_native_packed-1"
	PACKED2="${MST}_native_packed-1"
else
	OOARCH="i586"
	PACKED="${MST}_native_packed-1"
	PACKED2="${MST}_native_packed-1"
fi

S="${WORKDIR}"
UP="${PACKED}_en-US.${BUILDID}/RPMS"
DESCRIPTION="OpenOffice productivity suite"

SRC_URI="x86? ( http://download.services.openoffice.org/files/stable/${PV}/OOo_${PV}_Linux_x86_install-rpm_en-US.tar.gz )
	amd64? ( http://download.services.openoffice.org/files/stable/${PV}/OOo_${PV}_Linux_x86-64_install-rpm-wJRE_en-US.tar.gz  )"

LANGS="ar as ast bg bn ca cs da de dz el en en_GB eo es et eu fi fr ga gl gu hi hu id is it ja ka km kn ko ku lt lv mk ml mr my nb nl nn oc om or pa_IN pl pt pt_BR ro ru sh si sk sl sr sv ta te th tr ug uk uz vi zh_CN zh_TW"

for X in ${LANGS} ; do
	[[ ${X} != "en" ]] && SRC_URI="${SRC_URI} linguas_${X}? (
		x86? ( "${FILEPATH}"/OOo_${MY_PV2}_Linux_x86_langpack-rpm_${X/_/-}.tar.gz )
		amd64? ( "${FILEPATH}"/OOo_${MY_PV2}_Linux_x86-64_langpack-rpm_${X/_/-}.tar.gz ) )"
	IUSE="${IUSE} linguas_${X}"
done

HOMEPAGE="http://www.openoffice.org/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="!app-office/libreoffice
	!app-office/openoffice
	!app-office/libreoffice-bin
	x11-libs/libXaw
	!prefix? ( sys-libs/glibc )
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	x11-libs/libXinerama
	>=media-libs/freetype-2.1.10-r2"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PDEPEND="java? ( >=virtual/jre-1.5 )"

RESTRICT="strip"

QA_EXECSTACK="usr/$(get_libdir)/openoffice/basis3.3/program/*
	usr/$(get_libdir)/openoffice/ure/lib/*"
QA_TEXTRELS="usr/$(get_libdir)/openoffice/basis3.3/program/libvclplug_genli.so \
	usr/$(get_libdir)/openoffice/basis3.3/program/python-core-2.6.1/lib/lib-dynload/_curses_panel.so \
	usr/$(get_libdir)/openoffice/basis3.3/program/python-core-2.6.1/lib/lib-dynload/_curses.so \
	usr/$(get_libdir)/openoffice/ure/lib/*"

src_unpack() {

	unpack ${A}

	cp "${FILESDIR}"/{50-openoffice-bin,wrapper.in} "${T}"
	eprefixify "${T}"/{50-openoffice-bin,wrapper.in}

	for i in base binfilter calc core01 core02 core03 core04 core05 core06 core07 draw graphicfilter images impress math ooofonts oooimprovement ooolinguistic pyuno testtool writer xsltfilter ; do
		rpm_unpack "./${UP}/${BASIS}-${i}-${MY_PV3}.${OOARCH}.rpm"
	done

	for j in base calc draw impress math writer; do
		rpm_unpack "./${UP}/openoffice.org3-${j}-${MY_PV3}.${OOARCH}.rpm"
	done

	rpm_unpack "./${UP}/openoffice.org3-${MY_PV3}.${OOARCH}.rpm"
	rpm_unpack "./${UP}/openoffice.org-ure-${UREVER}-${BUILDID}.${OOARCH}.rpm"

	rpm_unpack "./${UP}/desktop-integration/openoffice.org3.3-freedesktop-menus-3.3-${BUILDID2}.noarch.rpm"

	use gnome && rpm_unpack "./${UP}/${BASIS}-gnome-integration-${MY_PV3}.${OOARCH}.rpm"
	use java && rpm_unpack "./${UP}/${BASIS}-javafilter-${MY_PV3}.${OOARCH}.rpm"

	# Unpack provided dictionaries, unless there is a better solution...
	rpm_unpack "./${UP}/openoffice.org3-dict-en-${MY_PV3}.${OOARCH}.rpm"
	rpm_unpack "./${UP}/openoffice.org3-dict-es-${MY_PV3}.${OOARCH}.rpm"
	rpm_unpack "./${UP}/openoffice.org3-dict-fr-${MY_PV3}.${OOARCH}.rpm"

	# Localization
	strip-linguas ${LANGS}
	if [[ -z "${LINGUAS}" ]]; then
		export LINGUAS="en"
	fi

	for k in ${LINGUAS}; do
		i="${k/_/-}"
		if [[ ${i} = "en" ]] ; then
			i="en-US"
			LANGDIR="${PACKED}_${i}.${BUILDID}/RPMS/"
		else
			LANGDIR="${PACKED2}_${i}.${BUILDID}/RPMS/"
		fi
		rpm_unpack "./${LANGDIR}/${BASIS}-${i}-${MY_PV3}.${OOARCH}.rpm"
		rpm_unpack "./${LANGDIR}/openoffice.org3-${i}-${MY_PV3}.${OOARCH}.rpm"
		for j in base binfilter calc draw help impress math res writer; do
			rpm_unpack "./${LANGDIR}/${BASIS}-${i}-${j}-${MY_PV3}.${OOARCH}.rpm"
		done
	done

}

src_install () {

	INSTDIR="/usr/$(get_libdir)/openoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv "${WORKDIR}"/opt/openoffice.org/* "${ED}${INSTDIR}" || die
	mv "${WORKDIR}"/opt/openoffice.org3/* "${ED}${INSTDIR}" || die

	#Menu entries, icons and mime-types
	cd "${ED}${INSTDIR}/share/xdg/"
	for desk in base calc draw impress javafilter math printeradmin qstart startcenter writer; do
		if [ "${desk}" = "javafilter" ] ; then
			use java || { rm javafilter.desktop; continue; }
		fi
		mv ${desk}.desktop openoffice.org-${desk}.desktop
		sed -i -e s/openoffice.org3/ooffice/g openoffice.org-${desk}.desktop || die
		domenu openoffice.org-${desk}.desktop
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
	dosym ${INSTDIR}/basis3.3 ${INSTDIR}/basis-link

	# Change user install dir
	sed -i -e "s/.openoffice.org\/3/.ooo3/g" "${ED}${INSTDIR}/program/bootstraprc" || die

	# Non-java weirdness see bug #99366
	use !java && rm -f "${ED}${INSTDIR}/ure/bin/javaldx"

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${T}/50-openoffice-bin"

}

pkg_preinst() {

	use gnome && gnome2_icon_savelist

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	use gnome && gnome2_icon_cache_update

	pax-mark -m "${EPREFIX}"/usr/$(get_libdir)/openoffice/program/soffice.bin

	elog " openoffice-bin does not provide integration with system spell "
	elog " dictionaries. Please install them manually through the Extensions "
	elog " Manager (Tools > Extensions Manager) or use the source based "
	elog " package instead. "
	elog
	elog " Dictionaries for English, French and Spanish are provided in "
	elog " ${EPREFIX}/usr/$(get_libdir)/openoffice/share/extension/install "
	elog " Other dictionaries can be found at Suns extension site. "
	elog

}

pkg_postrm() {

	fdo-mime_desktop_database_update
	use gnome && gnome2_icon_cache_update

}
