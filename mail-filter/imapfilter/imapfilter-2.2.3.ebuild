# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-2.2.3.ebuild,v 1.1 2011/06/11 15:15:59 eras Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="https://github.com/downloads/lefcha/imapfilter/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-libs/libpcre
	>=dev-lang/lua-5.1"
DEPEND="${RDEPEND}"

src_prepare() {
	# /usr/local -> /usr
	sed -i -e "/incdirs/s:local/::g" \
		-e "/libdirs/s:local/::g" \
		configure
}

src_configure() {
	# econf not possible
	./configure -p /usr -b /usr/bin -s /usr/share/imapfilter -m /usr/share/man || die "configure failed"
}

src_compile() {
	emake MYCFLAGS="${CFLAGS}" CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README samples/*
	doman doc/imapfilter.1 doc/imapfilter_config.5
}
