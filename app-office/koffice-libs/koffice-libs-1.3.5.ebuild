# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-libs/koffice-libs-1.3.5.ebuild,v 1.3 2005/04/09 13:03:40 josejx Exp $

MAXKOFFICEVER=1.3.5
KMNAME=koffice
KMMODULE=lib
inherit kde-meta eutils

DESCRIPTION="shared koffice libraries"
HOMEPAGE="http://www.koffice.org/"
SRC_URI="$SRC_URI mirror://kde/stable/${KMNAME}/src/${KMNAME}-${PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~ppc"

IUSE=""
SLOT="0"

DEPEND="dev-util/pkgconfig"

RDEPEND="$DEPEND $(deprange $PV $MAXKOFFICEVER app-office/koffice-data)"

KMEXTRA="
	interfaces/
	plugins/
	tools/
	filters/olefilters/
	filters/xsltfilter/
	filters/generic_wrapper/
	kounavail/
	doc/koffice
	doc/thesaurus"

KMEXTRACTONLY="
	kchart/kdchart"

need-kde 3.1

src_unpack() {
	kde-meta_src_unpack unpack

	# Force the compilation of libkopainter.
	sed -i 's:$(KOPAINTERDIR):kopainter:' $S/lib/Makefile.am

	kde-meta_src_unpack makefiles
}
