# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapfilter/imapfilter-0.8.9.ebuild,v 1.1 2003/07/17 17:33:29 antifa Exp $

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

	./config -d ${D}/usr -b ${D}/usr/bin -m ${D}/usr/man || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {
	make install

	dodoc LICENSE NEWS README sample.imapfilterrc

}
