# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/vyqchat/vyqchat-0.2.8.ebuild,v 1.2 2007/02/22 22:20:17 armin76 Exp $

inherit eutils

DESCRIPTION="QT based Vypress Chat clone for X."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

IUSE="arts"

DEPEND="=x11-libs/qt-3*
	arts? ( media-libs/libsndfile
		media-libs/libao
		kde-base/arts )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	econf \
		--with-x \
		--with-Qt-dir=/usr/qt/3 \
		$(use_with arts) \
		$(use_with arts sndfile) \
		$(use_with arts libao) \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog FAQ NEWS PROTOCOL README README-KEYS \
		THANKS TODO || die "dodoc failed"
}
