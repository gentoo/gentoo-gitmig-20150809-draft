# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SpamAssassin/Mail-SpamAssassin-2.55-r1.ebuild,v 1.4 2003/06/18 17:24:29 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Mail::SpamAssassin - A program to filter spam"
SRC_URI="http://www.spamassassin.org/released/${P}.tar.gz"
HOMEPAGE="http://www.spamassassin.org"
IUSE=""
SLOT="0"
LICENSE="GPL-2 | Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="dev-perl/Net-DNS
	dev-perl/HTML-Parser
	dev-perl/PodParser
	dev-perl/Time-Local"

myconf="INST_PREFIX=/usr SITEPREFIX=\$(PREFIX) INST_SYSCONFDIR=/etc SYSCONFDIR=${D}/etc RUN_RAZOR1_TESTS=n RUN_RAZOR2_TESTS=n"
mymake="PREFIX=/usr SYSCONFDIR=/etc"
mydoc="License Changes procmailrc.example sample-nonspam.txt sample-spam.txt"



src_compile() {

	perl-module_src_compile
	dodir /etc/mail/spamassassin

}

src_install () {

	perl-module_src_install

	dodir /etc/init.d /etc/conf.d
	cp ${FILESDIR}/spamd.init ${D}/etc/init.d/spamd
	chmod +x ${D}/etc/init.d/spamd
	cp ${FILESDIR}/spamd.conf ${D}/etc/conf.d/spamd



}
