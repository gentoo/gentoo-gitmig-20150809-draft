# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-kfile-plugins/kdegraphics-kfile-plugins-3.5.7.ebuild,v 1.8 2007/08/28 19:57:17 philantrop Exp $

KMNAME=kdegraphics
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdegraphics"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="openexr"
DEPEND="media-libs/tiff
	openexr? ( media-libs/openexr )"

# compilation of the tiff plugin depends on the check in acinclude.m4.in,
# which doesn't have a switch.

# ps installed with kghostview, pdf installed with kpdf
KMEXTRACTONLY="kfile-plugins/ps kfile-plugins/pdf"

# cf. bug 189798. Applied unconditonally as it's downwards compatible.
PATCHES="${FILESDIR}/${P}-openexr-1.6.0.patch"

src_compile() {
	local myconf="$myconf $(use_with openexr)"
	kde-meta_src_compile
}
