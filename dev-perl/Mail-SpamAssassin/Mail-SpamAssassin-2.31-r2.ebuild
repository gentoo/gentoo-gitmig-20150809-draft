# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.19.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Mail::SpamAssassin - A program to filter spam"
SRC_URI="http://www.spamassassin.org/released/${P}.tar.gz"
HOMEPAGE="http://www.spamassassin.org"

DEPEND="dev-perl/Net-DNS dev-perl/Time-HiRes"
LICENSE="GPL-2 | Artistic"

mydoc="License TODO"

src_install () {
	make PREFIX=${D}/usr INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	LOCAL_RULES_DIR=${D}/etc/mail/spamassassin \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
	dodoc Changes MANIFEST README TODO License
	dodoc procmailrc.example sample-nonspam.txt sample-spam.txt
	dodir /etc/init.d /etc/conf.d
	cp ${FILESDIR}/spamd.init ${D}/etc/init.d/spamd
	chmod +x ${D}/etc/init.d/spamd
	cp ${FILESDIR}/spamd.conf ${D}/etc/conf.d/spamd
}
