# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-2.3.6.ebuild,v 1.1 2010/08/15 13:37:02 scarabeus Exp $

EAPI=2
KDE_LINGUAS="ca cs da de el es_AR es fr it ja nl pl pt_BR ru sr@Latn sr tr zh_TW"
inherit kde4-base

MY_P=${P}-Source

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5."
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="media-libs/libdvdread
	>=media-libs/libmpeg2-0.5.1
	media-libs/xine-lib
	>=media-video/ffmpeg-0.5"
RDEPEND="${DEPEND}
	media-video/dvdauthor
	media-video/mplayer"

S=${WORKDIR}/${MY_P}

DOCS="README"

pkg_postinst() {
	kde4-base_pkg_postinst
	has_version '>=app-cdr/k3b-1.50' || elog "If you want K3b burning support in ${P}, please install app-cdr/k3b separately."
}
