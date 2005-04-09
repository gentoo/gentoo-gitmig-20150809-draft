# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kpresenter/kpresenter-1.3.5.ebuild,v 1.3 2005/04/09 13:12:35 josejx Exp $

KMNAME=koffice
MAXKOFFICEVER=1.3.5
inherit kde-meta eutils

DESCRIPTION="KOffice Presentation Tool"
HOMEPAGE="http://www.koffice.org/"
SRC_URI="$SRC_URI mirror://kde/stable/${KMNAME}/src/${KMNAME}-${PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~ppc"

IUSE=""
SLOT="0"

DEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	dev-util/pkgconfig"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkoscript lib/koscript
	libkospell lib/kospell
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store"

KMEXTRACTONLY="lib/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/kpresenter"

need-kde 3.1

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile first liboofilter because it's needed by the kpresenter's OOo filters
	echo "SUBDIRS = liboofilter kpresenter" > $S/filters/Makefile.am

	kde-meta_src_unpack makefiles
}
