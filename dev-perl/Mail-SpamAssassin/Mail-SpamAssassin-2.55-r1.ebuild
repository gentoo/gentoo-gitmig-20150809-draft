# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SpamAssassin/Mail-SpamAssassin-2.55-r1.ebuild,v 1.2 2003/06/18 14:29:29 mcummings Exp $

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

mydoc="License Changes procmailrc.example sample-nonspam.txt sample-spam.txt"
myinst="LOCAL_RULES_DIR=${D}/etc/mail/spamassassin"
myconf="SYSCONFDIR=${D}/etc INST_PREFIX=/usr RUN_RAZOR1_TESTS=n RUN_RAZOR2_TESTS=n"


src_compile() {

	perl-module_src_prep
	dodir /etc/mail/spamassassin

}

src_install () {

	perl-module_src_install

	dodir /etc/init.d /etc/conf.d
	cp ${FILESDIR}/spamd.init ${D}/etc/init.d/spamd
	chmod +x ${D}/etc/init.d/spamd
	cp ${FILESDIR}/spamd.conf ${D}/etc/conf.d/spamd

	#for FILE in `find ${D}usr/share/spamassassin/ -type f -name "*.cf"`; do
	#sed -i -e "s:${D}::g" ${FILE}
	#done

	#sed -i -e "s:${D}::g" ${D}/usr/bin/sa-learn
	#sed -i -e "s:${D}::g" ${D}/usr/bin/spamassassin
	#chmod 555 ${D}/usr/bin/spamassassin

	#sed -i -e "s:${D}::g" ${D}/usr/bin/spamd 
	#chmod 555 ${D}/usr/bin/spamd

}
