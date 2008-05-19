# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-arabicfonts/sil-arabicfonts-1.0.ebuild,v 1.2 2008/05/19 02:34:43 dirtyepic Exp $

inherit font

DESCRIPTION="SIL Opentype Unicode fonts for Arabic Languages"
HOMEPAGE="http://scripts.sil.org/ArabicFonts"
SRC_URI="mirror://gentoo/ttf-${PN}-${PV}.tgz"

LICENSE="SIL-freeware"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

DOCS=""
FONT_SUFFIX="ttf"
S="${WORKDIR}/ttf-${P}"
FONT_S="${S}"
