# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/libreoffice-bin/libreoffice-bin-3.3.0_rc4.ebuild,v 1.1 2011/01/23 14:42:30 suka Exp $

EAPI="3"

inherit eutils fdo-mime gnome2-utils rpm multilib

IUSE="gnome java kde"

MY_PV="${PV/_/-}"
MY_PV2="${PV/_/}"
BVER="3.3.0-6"
UREVER="1.7.0-6"
BASIS="libobasis3.3"
FILEPATH="http://download.documentfoundation.org/libreoffice/testing/${MY_PV}/rpm/"

if [ "${ARCH}" = "amd64" ] ; then
	LOARCH="x86_64"
	LOARCH2="x86-64"
else
	LOARCH="i586"
	LOARCH2="x86"
fi

S="${WORKDIR}/en-US/RPMS"
UP="LibO_${MY_PV2}_Linux_${LOARCH2}_install-rpm_en-US/RPMS"
DESCRIPTION="LibreOffice productivity suite."

SRC_URI="amd64? ( ${FILEPATH}/x86_64/LibO_${MY_PV2}_Linux_x86-64_install-rpm_en-US.tar.gz
		${FILEPATH}/x86_64/LibO_${MY_PV2}_Linux_x86-64_helppack-rpm_en-US.tar.gz )
	x86? ( ${FILEPATH}/x86/LibO_${MY_PV2}_Linux_x86_install-rpm_en-US.tar.gz
		${FILEPATH}/x86/LibO_${MY_PV2}_Linux_x86_helppack-rpm_en-US.tar.gz )"

LANGS="af ar as ast be_BY bg bn bo br brx bs ca ca_XV cs cy da de dgo dz el en en_GB en_ZA eo es et eu fa fi fr ga gd gl gu he hi hr hu id is it ja ka kk km kn ko kok ks ku ky lo lt lv mai mk ml mn mni mr ms my nb ne nl nn nr ns oc om or pa_IN pap pl ps pt pt_BR ro ru rw sa_IN sat sd sh si sk sl sq sr ss st sv sw_TZ ta te tg th ti tn tr ts ug uk uz ve vi xh zh_CN zh_TW zu"

for X in ${LANGS} ; do
	[[ ${X} != "en" ]] && SRC_URI="${SRC_URI} linguas_${X}? (
		amd64? ( "${FILEPATH}"/x86_64/LibO_${MY_PV2}_Linux_x86-64_langpack-rpm_${X/_/-}.tar.gz
			"${FILEPATH}"/x86_64/LibO_${MY_PV2}_Linux_x86-64_helppack-rpm_${X/_/-}.tar.gz )
		x86? ( "${FILEPATH}"/x86/LibO_${MY_PV2}_Linux_x86_langpack-rpm_${X/_/-}.tar.gz
			"${FILEPATH}"/x86/LibO_${MY_PV2}_Linux_x86_helppack-rpm_${X/_/-}.tar.gz ) )"
	IUSE="${IUSE} linguas_${X}"
done

HOMEPAGE="http://www.documentfoundation.org"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/libXaw
	sys-libs/glibc
	>=dev-lang/perl-5.0
	app-arch/zip
	app-arch/unzip
	x11-libs/libXinerama
	>=media-libs/freetype-2.1.10-r2"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PDEPEND="java? ( >=virtual/jre-1.5 )"

PROVIDE="virtual/ooo"
RESTRICT="strip binchecks"

QA_EXECSTACK="usr/$(get_libdir)/libreoffice/basis3.3/program/*
	usr/$(get_libdir)/libreoffice/ure/lib/*"
QA_TEXTRELS="usr/$(get_libdir)/libreoffice/ure/lib/*"
QA_PRESTRIPPED="usr/$(get_libdir)/libreoffice/basis3.3/program/*
	usr/$(get_libdir)/libreoffice/basis3.3/program/python-core-2.6.1/lib/lib-dynload/*
	usr/$(get_libdir)/libreoffice/program/*
	usr/$(get_libdir)/libreoffice/ure/bin/*
	usr/$(get_libdir)/libreoffice/ure/lib/*"

RESTRICT="mirror"

src_unpack() {

	unpack ${A}

	for i in base binfilter calc core01 core02 core03 core04 core05 core06 \
		core07 draw graphicfilter images impress math ogltrans ooofonts \
		ooolinguistic pyuno testtool writer xsltfilter ; do
		rpm_unpack "./${UP}/${BASIS}-${i}-${BVER}.${LOARCH}.rpm"
	done

	rpm_unpack "./${UP}/libreoffice3-${BVER}.${LOARCH}.rpm"
	rpm_unpack "./${UP}/libreoffice3-ure-${UREVER}.${LOARCH}.rpm"

	for j in base calc draw impress math writer; do
		rpm_unpack "./${UP}/libreoffice3-${j}-${BVER}.${LOARCH}.rpm"
	done

	rpm_unpack "./${UP}/desktop-integration/libreoffice3.3-freedesktop-menus-3.3-6.noarch.rpm"

	use gnome && rpm_unpack "./${UP}/${BASIS}-gnome-integration-${BVER}.${LOARCH}.rpm"
	use kde && rpm_unpack "./${UP}/${BASIS}-kde-integration-${BVER}.${LOARCH}.rpm"
	use java && rpm_unpack "./${UP}/${BASIS}-javafilter-${BVER}.${LOARCH}.rpm"

	# Extensions
	for k in mediawiki-publisher nlpsolver pdf-import presentation-minimizer presenter-screen report-builder; do
		rpm_unpack "./${UP}/${BASIS}-extension-${k}-${BVER}.${LOARCH}.rpm"
	done

	# English support installed by default
	rpm_unpack "./${UP}/${BASIS}-en-US-${BVER}.${LOARCH}.rpm"
	rpm_unpack "./${UP}/libreoffice3-en-US-${BVER}.${LOARCH}.rpm"
	rpm_unpack "./LibO_${MY_PV2}_Linux_${LOARCH2}_helppack-rpm_en-US/RPMS//${BASIS}-en-US-help-${BVER}.${LOARCH}.rpm"
	for s in base binfilter calc math res writer ; do
		rpm_unpack "./${UP}/${BASIS}-en-US-${s}-${BVER}.${LOARCH}.rpm"
	done

	# Lang files
	# TODO: Install dictionaries
	for l in ${LINGUAS}; do
		m="${l/_/-}"
		if [[ ${m} != "en" ]] ; then
			LANGDIR="LibO_${MY_PV2}_Linux_${LOARCH2}_langpack-rpm_${m}/RPMS/"
			rpm_unpack "./${LANGDIR}/${BASIS}-${m}-${BVER}.${LOARCH}.rpm"
			rpm_unpack "./${LANGDIR}/libreoffice3-${m}-${BVER}.${LOARCH}.rpm"
			for n in base binfilter calc math res writer; do
				rpm_unpack "./${LANGDIR}/${BASIS}-${m}-${n}-${BVER}.${LOARCH}.rpm"
			done
			# Help files
			LANGDIR2="LibO_${MY_PV2}_Linux_${LOARCH2}_helppack-rpm_${m}/RPMS/"
			rpm_unpack "./${LANGDIR2}/${BASIS}-${m}-help-${BVER}.${LOARCH}.rpm"
		fi
	done
}

src_install () {

	INSTDIR="/usr/$(get_libdir)/libreoffice"

	einfo "Installing OpenOffice.org into build root..."
	dodir ${INSTDIR}
	mv "${WORKDIR}"/opt/libreoffice/* "${ED}${INSTDIR}" || die

	#Menu entries, icons and mime-types
	cd "${ED}${INSTDIR}/share/xdg/"

	for desk in base calc draw impress javafilter math printeradmin qstart startcenter writer; do
		if [ "${desk}" = "javafilter" ] ; then
			use java || { rm javafilter.desktop; continue; }
		fi
		mv ${desk}.desktop libreoffice-${desk}.desktop
		sed -i -e s/Exec=libreoffice/Exec=loffice/g libreoffice-${desk}.desktop || die
		domenu libreoffice-${desk}.desktop
	done
	insinto /usr/share
	doins -r "${WORKDIR}"/usr/share/icons
	doins -r "${WORKDIR}"/usr/share/mime

	# Install wrapper script
	newbin "${FILESDIR}/wrapper.in" loffice
	sed -i -e s/LIBDIR/$(get_libdir)/g "${ED}/usr/bin/loffice" || die

	# Component symlinks
	# Disabled, trouble with parallel installing openoffice
#	for app in base calc draw impress math writer; do
#		dosym loffice /usr/bin/lo${app}
#	done

	dosym ${INSTDIR}/program/spadmin /usr/bin/loffice-printeradmin
#	dosym ${INSTDIR}/program/soffice /usr/bin/soffice

	rm -f "${ED}${INSTDIR}/basis-link" || die
	dosym ${INSTDIR}/basis3.3 ${INSTDIR}/basis-link

	# Non-java weirdness see bug #99366
	use !java && rm -f "${ED}${INSTDIR}/ure/bin/javaldx"

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${FILESDIR}/50-libreoffice-bin"

}

pkg_preinst() {
	use gnome && gnome2_icon_savelist
}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	use gnome && gnome2_icon_cache_update

	[[ -x /sbin/chpax ]] && [[ -e /usr/$(get_libdir)/libreoffice/program/soffice.bin ]] && chpax -zm /usr/$(get_libdir)/libreoffice/program/soffice.bin

	elog " libreoffice-bin does not provide integration with system spell "
	elog " dictionaries. Please install them manually through the Extensions "
	elog " Manager (Tools > Extensions Manager) or use the source based "
	elog " package instead. "
	elog

}

pkg_postrm() {
	fdo-mime_desktop_database_update
	use gnome && gnome2_icon_cache_update
}
