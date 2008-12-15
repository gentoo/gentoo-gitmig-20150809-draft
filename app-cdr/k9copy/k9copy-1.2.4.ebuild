# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.2.4.ebuild,v 1.1 2008/12/15 22:37:24 tgurr Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

MY_P="${P/_p/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5."
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-cdr/k3b-1.0.5-r3:0
	media-libs/libdvdread
	dev-libs/dbus-qt3-old
	>=media-video/ffmpeg-0.4.9_p20081014
	media-video/mplayer"

RDEPEND="${DEPEND}
	media-video/dvdauthor"

need-kde 3.5

LANGS="ca cs de el es_AR fr it nl pl pt_BR ru sr tr zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup() {
	kde_pkg_setup

	if ! built_with_use x11-libs/qt:3 opengl ; then
		eerror "K9Copy needs Qt 3 built with OpenGL support. Please set the"
		eerror "\"opengl\" use flag and run \"emerge --oneshot x11-libs/qt:3\""
		die "Please follow the above error message."
	fi
}

src_unpack() {
	kde_src_unpack

	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.2.3-desktop-entry-2.diff"

	local MAKE_LANGS
	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}.po"
	done
	sed -i -e "s:POFILES =.*:POFILES = ${MAKE_LANGS}:" Makefile.am

	rm -f "${S}"/configure
}

src_compile() {
	local myconf="--enable-k3bdevices"

	kde_src_compile
}
