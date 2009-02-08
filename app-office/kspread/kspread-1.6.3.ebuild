# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kspread/kspread-1.6.3.ebuild,v 1.3 2009/02/08 15:32:48 maekke Exp $

KMNAME=koffice
MAXKOFFICEVER=1.6.3
inherit kde-meta eutils

DESCRIPTION="KOffice spreadsheet application."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	$(deprange $PV $MAXKOFFICEVER app-office/kchart)
	$(deprange $PV $MAXKOFFICEVER app-office/kexi)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkochart interfaces
	libkrossmain lib/kross/main
	libkrossapi lib/kross/api
	libkexidb kexi/kexidb
	libkexidbparser kexi/kexidb/parser"

KMEXTRACTONLY="lib/
	interfaces/
	filters/kexi
	kexi/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/kspread"

PATCHES="${FILESDIR}/kspread-1.6.3-validate-desktop.diff
	${FILESDIR}/kspread-gcc43.patch"

need-kde 3.4

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile liboofilter first
	echo "SUBDIRS = liboofilter kspread" > ${S}/filters/Makefile.am

	# Work around broken conditional
	echo "SUBDIRS = applixspread csv dbase gnumeric latex opencalc html qpro excel kexi" > ${S}/filters/kspread/Makefile.am

	for i in $(find "${S}"/lib -iname "*\.ui"); do
		${QTDIR}/bin/uic ${i} > ${i%.ui}.h
	done

	kde-meta_src_unpack makefiles
}
