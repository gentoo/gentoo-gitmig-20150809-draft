# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/mecab-skkserv/mecab-skkserv-0.03.ebuild,v 1.1 2007/08/25 16:05:38 matsuu Exp $

inherit eutils

DESCRIPTION="mecab-skkserv is a Kana-Kanji conversion server using MeCab."
HOMEPAGE="http://chasen.org/~taku/software/mecab-skkserv/"
SRC_URI="http://chasen.org/~taku/software/mecab-skkserv/${P}.tar.gz"

LICENSE="GPL-2 ipadic"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=app-text/mecab-0.91"
RDEPEND="${DEPEND}
	sys-apps/xinetd"

PROVIDE="virtual/skkserv"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/^dictdir/s@lib@$(get_libdir)@" Makefile* || die
}

src_install() {

	emake DESTDIR="${D}" install || die "einstall failed."

	# for running skkserv from xinetd
	insinto /etc/xinetd.d; doins "${FILESDIR}"/mecab-skkserv || die
	dodoc README NEWS AUTHORS
	dohtml index.html
}
