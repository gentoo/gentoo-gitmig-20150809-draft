# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kpresenter/kpresenter-1.5.1.ebuild,v 1.4 2006/08/16 12:55:10 corsair Exp $

KMNAME=koffice
MAXKOFFICEVER=${PV}
inherit kde-meta eutils

DESCRIPTION="KOffice presentation program."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)"

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
	libkstore lib/store"

KMEXTRACTONLY="lib/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/kpresenter
	filters/libdialogfilter"

need-kde 3.4

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile filters first.
	echo "SUBDIRS = liboofilter libdialogfilter kpresenter" > $S/filters/Makefile.am

	for i in $(find ${S}/lib -iname "*\.ui"); do
		${QTDIR}/bin/uic ${i} > ${i%.ui}.h
	done

	kde-meta_src_unpack makefiles
}
