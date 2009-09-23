# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/imapfilter/imapfilter-2.0.10.ebuild,v 1.4 2009/09/23 17:53:33 patrick Exp $

inherit eutils

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/openssl
	dev-libs/libpcre
	>=dev-lang/lua-5.1"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/${P}

	# http://lists.hellug.gr/pipermail/imapfilter-devel/2008/000606.html
	epatch "${FILESDIR}/${P}-deprecated.patch"
	# econf not possible
	./configure -p /usr -b /usr/bin -s /usr/share/imapfilter -m /usr/share/man
}

src_compile() {
	emake MYCFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS README sample.config.lua sample.extend.lua
}
