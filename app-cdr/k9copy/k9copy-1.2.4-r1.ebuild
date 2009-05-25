# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.2.4-r1.ebuild,v 1.1 2009/05/25 01:24:26 tampakrap Exp $

EAPI="2"

LANGS="ca cs de el es_AR fr it nl pl pt_BR ru sr tr zh_TW"

ARTS_REQUIRED="never"

USE_KEG_PACKAGING="1"

inherit kde

MY_P="${P/_p/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5."
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="!<app-cdr/k9copy-1.2.4-r1
	app-cdr/k3b:3.5
	media-libs/libdvdread
	dev-libs/dbus-qt3-old
	>=media-video/ffmpeg-0.4.9_p20081014
	media-video/mplayer
	x11-libs/qt:3[opengl]"

RDEPEND="${DEPEND}
	media-video/dvdauthor"

need-kde 3.5

PATCHES=( "${FILESDIR}/${PN}-1.2.3-desktop-entry-2.diff" )

src_prepare() {
	kde_src_prepare

	local MAKE_LANGS
	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}.po"
	done
	sed -i -e "s:POFILES =.*:POFILES = ${MAKE_LANGS}:" Makefile.am

	rm -f "${S}"/configure
}

src_configure() {
	local myconf="--enable-k3bdevices"

	kde_src_configure
}
