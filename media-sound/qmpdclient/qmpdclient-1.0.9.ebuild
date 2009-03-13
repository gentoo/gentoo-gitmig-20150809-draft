# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-1.0.9.ebuild,v 1.7 2009/03/13 00:37:10 tcunha Exp $

EAPI=1
inherit eutils multilib qt4 toolchain-funcs

DESCRIPTION="An easy-to-use Qt4 client for MPD"
HOMEPAGE="http://havtknut.tihlde.org/qmpdclient"
SRC_URI="http://havtknut.tihlde.org/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc sparc x86"
IUSE=""

DEPEND="|| ( x11-libs/qt-gui:4 =x11-libs/qt-4.3* )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix the install path
	sed -i -e "s:PREFIX = /usr/local:PREFIX = /usr:" qmpdclient.pro \
		|| die "sed failed"
}

src_compile() {
	eqmake4 || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	dodoc README AUTHORS THANKSTO Changelog
	for res in 16 22 32 64 128 ; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins icons/qmpdclient${res}.png ${PN}.png
	done

	dobin qmpdclient || die "dobin failed"
	make_desktop_entry qmpdclient "QMPDClient" ${PN} "Qt;AudioVideo;Audio;"
}
