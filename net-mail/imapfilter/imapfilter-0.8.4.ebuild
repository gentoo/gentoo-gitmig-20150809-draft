# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapfilter/imapfilter-0.8.4.ebuild,v 1.3 2003/02/13 14:32:31 vapier Exp $

DESCRIPTION="An IMAP mail filtering utility"
HOMEPAGE="http://imapfilter.hellug.gr"
SRC_URI="http://imapfilter.hellug.gr/source/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/glibc
	dev-libs/openssl"

S=${WORKDIR}/${P}

src_compile() {

	./config || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	dobin imapfilter

	doman imapfilter.1 imapfilterrc.5

	dodoc LICENSE NEWS README sample.imapfilterrc

}
