# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/spamassassin/spamassassin-2.11-r1.ebuild,v 1.1 2002/04/12 19:42:20 g2boojum Exp $

P="Mail-SpamAssassin-${PV}"
S=${WORKDIR}/${P}
DESCRIPTION="A spam filter written in Perl"
SRC_URI="http://spamassassin.org/released/${P}.tar.gz"
HOMEPAGE="http://spamassassin.org"

DEPEND=">=sys-devel/perl-5.6.1-r3
        dev-perl/Net-DNS"

src_compile() {
	perl Makefile.PL
	emake || die
}

src_install () {
	make PREFIX=${D}/usr INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	LOCAL_RULES_DIR=${D}/etc/mail/spamassassin \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
}
