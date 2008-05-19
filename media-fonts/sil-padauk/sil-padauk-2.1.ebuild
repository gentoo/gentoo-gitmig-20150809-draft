# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-padauk/sil-padauk-2.1.ebuild,v 1.1 2008/05/19 20:05:29 dirtyepic Exp $

inherit font

DESCRIPTION="SIL Padauk - SIL fonts for Myanmar"
HOMEPAGE="http://scripts.sil.org/padauk"
SRC_URI="mirror://gentoo/ttf-${P}.tgz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/ttf-${P}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="FONTLOG OFL-FAQ"

pkg_postinst() {
	font_pkg_postinst
	echo
	ewarn "The extension of the Myanmar script in Unicode is currently under"
	ewarn "development.  Padauk conforms to the proposed extensions but is not"
	ewarn "officially Unicode compliant.  Assuming these extensions are accepted"
	ewarn "into Unicode in the future, you will need to transcode your documents"
	ewarn "at that time."
	ewarn
	ewarn "Padauk requires Graphite-capable font rendering technologies to properly"
	ewarn "render the Myanmar script.  Gentoo does not currently include these"
	ewarn "technologies.  See bug #209765 and http://scripts.sil.org/RenderingGraphite"
	ewarn "for more information."
	echo
}
