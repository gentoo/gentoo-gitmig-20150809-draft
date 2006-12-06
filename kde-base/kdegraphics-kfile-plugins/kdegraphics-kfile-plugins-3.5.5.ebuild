# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-kfile-plugins/kdegraphics-kfile-plugins-3.5.5.ebuild,v 1.7 2006/12/06 13:53:41 kloeri Exp $

KMNAME=kdegraphics
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdegraphics"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="openexr"
DEPEND="media-libs/tiff
	openexr? ( media-libs/openexr )"

# compilation of the tiff plugin depends on the check in acinclude.m4.in,
# which doesn't have a switch.

# ps installed with kghostview, pdf installed with kpdf
KMEXTRACTONLY="kfile-plugins/ps kfile-plugins/pdf"

src_compile() {
	myconf="$myconf $(use_with openexr)"
	kde-meta_src_compile
}
