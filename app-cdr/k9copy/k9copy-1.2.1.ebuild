# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k9copy/k9copy-1.2.1.ebuild,v 1.3 2008/01/09 15:13:33 keytoaster Exp $

EAPI="1"

inherit kde

MY_P="${P/_p/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="k9copy is a DVD backup utility which allows the copy of one or more titles from a DVD9 to a DVD5"
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="media-video/dvdauthor
	media-libs/libdvdread
	media-libs/libdvdnav
	app-cdr/dvd+rw-tools
	>=media-video/vamps-0.98
	>=app-cdr/k3b-0.12.10
	dev-libs/dbus-qt3-old
	sys-apps/hal
	media-video/mplayer"

need-kde 3.5

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

	# Fix the desktop file for compliance with the spec.
	sed -i -e '/MimeTypes/d' "${S}/src/${PN}.desktop"
	sed -i -e '/Icon/s/.png//' "${S}/src/${PN}.desktop"
}

src_install() {
	kde_src_install

	dodir /usr/share/applications/kde
	mv "${D}/usr/share/applnk/Multimedia/k9copy.desktop" \
		"${D}/usr/share/applications/kde"
}
