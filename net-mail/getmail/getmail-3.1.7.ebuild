# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-3.1.7.ebuild,v 1.6 2004/07/15 01:48:50 agriffis Exp $

DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://www.qcc.ca/~charlesc/software/getmail-3.0/"
SRC_URI="http://www.qcc.ca/~charlesc/software/getmail-3.0/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/python"

src_install () {
	into /usr
	doman getmail.1
	dobin getmail
	dobin getmail_maildir
	dobin getmail_mbox

	insinto /usr/lib/getmail
	doins getmail.py
	doins ConfParser.py
	doins timeoutsocket.py
	doins getmail_classes.py
	doins getmail_constants.py
	doins getmail_defaults.py
	doins getmail_mbox.py
	doins getmail_utilities.py

	dodoc BUGS CHANGELOG COPYING THANKS TODO *.txt getmailrc-example
	dohtml *.html
}
