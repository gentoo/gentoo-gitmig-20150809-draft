# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-2.3.8.ebuild,v 1.4 2002/08/14 12:05:25 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://www.qcc.ca/~charlesc/software/getmail-2.0/"
SRC_URI="http://www.qcc.ca/~charlesc/software/getmail-2.0/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

src_install () {
	into /usr
	doman getmail.1
	dobin getmail

	# fudged, don't like, but works
	insinto /usr/lib/getmail
	doins getmail.py
	doins ConfParser.py
	doins timeoutsocket.py

	dodoc BUGS CHANGELOG COPYING THANKS TODO *.txt getmailrc-example
	dohtml *.html
}
