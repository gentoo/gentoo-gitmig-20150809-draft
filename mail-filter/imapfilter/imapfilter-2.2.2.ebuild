# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-2.2.2.ebuild,v 1.1 2010/09/25 07:03:24 radhermit Exp $

inherit toolchain-funcs

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-libs/libpcre
	>=dev-lang/lua-5.1"
DEPEND="${RDEPEND}"

src_compile() {
	# econf not possible
	./configure -p /usr -b /usr/bin -s /usr/share/imapfilter -m /usr/share/man || die "configure failed"
	emake MYCFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "parallel make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README sample.config.lua sample.extend.lua || die "dodoc failed"
}
