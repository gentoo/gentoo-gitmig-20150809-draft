# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SpamAssassin/Mail-SpamAssassin-2.60.ebuild,v 1.3 2003/09/08 11:38:13 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Mail::SpamAssassin - A program to filter spam"
SRC_URI="http://www.spamassassin.org/released/${P}.tar.gz"
HOMEPAGE="http://www.spamassassin.org"
IUSE=""
SLOT="0"
LICENSE="GPL-2 | Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

DEPEND="dev-perl/Net-DNS
	dev-perl/HTML-Parser
	dev-perl/PodParser
	dev-perl/Time-Local
	berkdb? ( dev-perl/DB_File ) "

RAZORVERINS=`best_version net-mail/razor`

myconf="INST_PREFIX=/usr SITEPREFIX=\$(PREFIX) INST_SYSCONFDIR=/etc SYSCONFDIR=${D}/etc CONTACT_ADDRESS=root@localhost"

# If ssl is enabled, spamc can be built with ssl support
if [ "`use ssl`" ];
then
	myconf="${myconf} ENABLE_SSL=yes"
fi

if [ ! -z "${RAZORVERINS}" ];
then
	myconf="${myconf} RUN_RAZOR2_TESTS=n"
fi

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

pkg_postinst() {
	perl-module_pkg_postinst

	ewarn "Message from the author of SpamAssassin:"
	einfo ""
	einfo "Perl 5.8 now uses Unicode internally by default, "
	einfo "which causes trouble for SpamAssassin (and almost"
	einfo "all other reasonably complex pieces of perl code!)."
	einfo ""
	einfo "Setting the LANG environment variable before any "
	einfo "invocation of SpamAssassin sometimes seems to help"
	einfo "fix it, like so:"
	einfo ""
	ewarn "  export LANG=en_US"
	einfo ""
	einfo "Notably, the LANG setting must not include utf8. "
	einfo "However, some folks have reported that this makes"
	einfo "no difference. ;)"
}
