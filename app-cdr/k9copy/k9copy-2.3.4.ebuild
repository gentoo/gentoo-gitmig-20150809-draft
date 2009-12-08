# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-2.3.4.ebuild,v 1.1 2009/12/08 09:33:09 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="ca cs de el es es_AR et fr it nl pl pt_BR ru sr sr@Latn tr zh_TW"
inherit kde4-base

MY_P="${P}-Source"
DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5."
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libdvdread
	>=media-libs/libmpeg2-0.5.1
	media-libs/xine-lib
	>=media-video/ffmpeg-0.5
	x11-libs/qt-dbus:4"
RDEPEND="${DEPEND}
	media-video/dvdauthor
	media-video/mplayer"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	kde4-base_pkg_postinst
	has_version '>=app-cdr/k3b-1.67' || elog "If you want K3b burning support in ${P}, please install app-cdr/k3b separately."
}
