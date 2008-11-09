# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-padauk/sil-padauk-2.4.ebuild,v 1.7 2008/11/09 12:07:29 vapier Exp $

inherit font

DESCRIPTION="SIL Padauk - SIL fonts for Myanmar"
HOMEPAGE="http://scripts.sil.org/padauk"
SRC_URI="mirror://gentoo/ttf-${P}.tar.gz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}
FONT_S=${S}
FONT_SUFFIX="ttf"
DOCS="doc/FONTLOG.txt"

pkg_postinst() {
	font_pkg_postinst
	echo
	ewarn "Padauk requires Graphite-capable font rendering technologies to properly"
	ewarn "render the Myanmar script.  Gentoo does not currently include these"
	ewarn "technologies.  See bug #209765 and http://scripts.sil.org/RenderingGraphite"
	ewarn "for more information."
	echo
}
