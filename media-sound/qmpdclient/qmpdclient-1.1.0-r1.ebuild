# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-1.1.0-r1.ebuild,v 1.1 2009/04/20 23:35:15 hwoarang Exp $

EAPI="2"

inherit qt4

MY_PN="${PN}-ne"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="QMPDClient with NBL additions, such as lyrics' display"
HOMEPAGE="http://bitcheese.net/wiki/QMPDClient"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4[dbus]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Fix the install path
	sed -i -e "s:PREFIX = /usr/local:PREFIX = /usr:" qmpdclient.pro \
		|| die "sed failed (install path)"

	# nostrip fix
	sed -i -e "s:CONFIG += :CONFIG += nostrip :" qmpdclient.pro \
		|| die "sed failed (nostrip)"

	sed -i -e "s:+= -O2 -g0 -s:+= -O2 -g0:" qmpdclient.pro \
		|| die "sed failed (nostrip)"
}

src_configure() {
	eqmake4 qmpdclient.pro
}

src_compile() {
	emake || die "emake failed"
	# generate translations
	emake translate || die "failed to generate translations"
}

src_install() {
	dodoc README AUTHORS THANKSTO Changelog || die "Installing docs failed"
	for res in 16 22 64 ; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins icons/qmpdclient${res}.png ${PN}.png || die "Installing icons failed"
	done

	newbin qmpdclient qmpdclient-ne || die "Installing binary failed"
	make_desktop_entry qmpdclient-ne "QMPDClient-ne" ${PN} \
		"Qt;AudioVideo;Audio;" || die "Installing desktop entry failed"

	# Install translations
	insinto /usr/share/QMPDClient/translations/
	doins -r lang/*.qm || die "failed to install translations"
}
