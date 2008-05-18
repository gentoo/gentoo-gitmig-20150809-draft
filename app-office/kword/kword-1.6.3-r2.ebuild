# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kword/kword-1.6.3-r2.ebuild,v 1.8 2008/05/18 01:06:05 hanno Exp $

KMNAME=koffice
MAXKOFFICEVER=${PV}
inherit kde-meta eutils

DESCRIPTION="KOffice word processor."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	$(deprange 1.6.2 $MAXKOFFICEVER app-office/kspread)
	>=app-text/wv2-0.1.8
	>=media-gfx/imagemagick-5.5.2
	>=app-text/libwpd-0.8.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkspreadcommon kspread"

KMEXTRACTONLY="
	lib/
	kspread/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/kword"

need-kde 3.5

PATCHES="${FILESDIR}/koffice-xpdf-CVE-2007-3387.diff
	${FILESDIR}/koffice-1.6.3-xpdf2-CVE-2007-4352-5392-5393.diff
	${FILESDIR}/kword-gcc43.patch"

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile libs first
	echo "SUBDIRS = liboofilter kword" > "$S"/filters/Makefile.am

	for i in $(find "${S}"/lib -iname "*\.ui"); do
		${QTDIR}/bin/uic ${i} > ${i%.ui}.h
	done

	kde-meta_src_unpack makefiles

	# Fix the desktop file. cf. bug 190006
	sed -i -e "s:x-mswrite:x-mswrite;:g" "${S}"/kword/kword.desktop
}
