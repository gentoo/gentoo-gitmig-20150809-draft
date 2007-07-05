# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmpdclient/qmpdclient-1.0.8.ebuild,v 1.2 2007/07/05 18:40:44 ticho Exp $

inherit eutils multilib qt4 toolchain-funcs

DESCRIPTION="An easy to use MPD client written in Qt4"
HOMEPAGE="http://havtknut.tihlde.org/qmpdclient"
SRC_URI="http://havtknut.tihlde.org/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~ppc ~x86"
IUSE=""

DEPEND="$(qt4_min_version 4.2)"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Fix a crasher for am64 and possibly others. Bug #183593.
	epatch "${FILESDIR}"/${PV}-argc-ref-fix.patch

	# Fix the install path
	sed -i -e "s:PREFIX = /usr/local:PREFIX = /usr:" qmpdclient.pro \
		|| die 'sed failed'
}

src_compile() {
	# Use our C(XX)FLAGS
	qmake qmpdclient.pro \
		QTDIR=/usr/$(get_libdir) \
		QMAKE=/usr/bin/qmake \
		QMAKE_CXX=$(tc-getCXX) \
		QMAKE_TARGET=release \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_LFLAGS_RELEASE="${LDFLAGS}" \
		|| die "qmake failed"

	emake || die "make failed"
}

src_install() {
	dodoc README AUTHORS THANKSTO Changelog
	for res in 16 22 32 64 128 ; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps/
		newins icons/qmpdclient${res}.png ${PN}.png
	done

	dobin qmpdclient || die "dobin failed"
	make_desktop_entry qmpdclient "QMPDClient" ${PN} "Qt;AudioVideo;Audio"
}
