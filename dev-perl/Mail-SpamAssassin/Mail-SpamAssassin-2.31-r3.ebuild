# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SpamAssassin/Mail-SpamAssassin-2.31-r3.ebuild,v 1.3 2002/07/25 04:13:26 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Mail::SpamAssassin - A program to filter spam"
SRC_URI="http://www.spamassassin.org/released/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.spamassassin.org"

SLOT="0"
DEPEND="dev-perl/Net-DNS
	dev-perl/Time-HiRes"

LICENSE="GPL-2 | Artistic"
SLOT="0"
KEYWORDS="*"

mydoc="License TODO Changes procmailrc.example sample-nonspam.txt sample-spam.txt"
myinst="LOCAL_RULES_DIR=${D}/etc/mail/spamassassin"

src_install () {
	
	base_src_install
	
	dodir /etc/init.d /etc/conf.d
	cp ${FILESDIR}/spamd.init ${D}/etc/init.d/spamd
	chmod +x ${D}/etc/init.d/spamd
	cp ${FILESDIR}/spamd.conf ${D}/etc/conf.d/spamd
}
