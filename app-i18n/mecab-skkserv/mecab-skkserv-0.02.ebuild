# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/mecab-skkserv/mecab-skkserv-0.02.ebuild,v 1.1 2005/04/02 06:50:40 usata Exp $

inherit eutils

DESCRIPTION="mecab-skkserv is a Kana-Kanji conversion server using MeCab."
HOMEPAGE="http://chasen.org/~taku/software/mecab-skkserv/"
SRC_URI="http://chasen.org/~taku/software/mecab-skkserv/${P}.tar.gz"

LICENSE="GPL-2 ipadic"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="=app-text/mecab-0.80*"
RDEPEND="${DEPEND} sys-apps/xinetd"

PROVIDE="virtual/skkserv"

src_install() {

	make DESTDIR="${D}" install || die "einstall failed."

	# for running skkserv from xinetd
	insinto /etc/xinetd.d; doins ${FILESDIR}/mecab-skkserv || die
	dodoc index.html README NEWS AUTHORS INSTALL
}
