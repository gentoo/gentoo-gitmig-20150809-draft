# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-gentium/sil-gentium-1.0.1.ebuild,v 1.1 2008/05/19 04:46:05 dirtyepic Exp $

inherit font

DESCRIPTION="SIL Gentium Unicode font for Latin and Greek languages."
HOMEPAGE="http://scripts.sil.org/gentium"
SRC_URI="mirror://gentoo/fonts-ttf-gentium-${PV}.tar.bz2"

LICENSE="SIL-freeware"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="doc"

DOCS="FONTLOG GENTIUM-FAQ QUOTES ISSUES HISTORY"
FONT_SUFFIX="ttf"

S="${WORKDIR}/fonts-ttf-gentium-${PV}"
FONT_S="${S}"

src_install() {
	font_src_install
	use doc && dodoc *.pdf
}
