# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamassassin-ruledujour/spamassassin-ruledujour-20040701.ebuild,v 1.5 2005/01/07 06:13:33 robbat2 Exp $

DESCRIPTION="SpamAssassin - Rules Du Jour & My Rules Du Jour"
HOMEPAGE="http://www.exit0.us/index.php/RulesDuJour http://www.rulesemporium.com/rules.htm"
SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~robbat2/distfiles/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="" # this is correct!
RDEPEND="app-shells/bash
		 mail-filter/spamassassin
		 net-misc/wget
		 sys-apps/grep
		 sys-apps/sed
		 dev-lang/perl
		 sys-apps/coreutils
		 virtual/cron
		 mail-client/mailx"

src_install() {
	SPAMASSASSIN_CONFDIR=/etc/mail/spamassassin
	SPAMASSASSIN_LIBDIR=/var/lib/spamassassin
	dodir $SPAMASSASSIN_CONFDIR $SPAMASSASSIN_LIBDIR
	into /usr
	dosbin bin/my_rules_du_jour
	# feed me seymour
	exeinto ${SPAMASSASSIN_LIBDIR}
	doexe bin/rules_du_jour
	insinto /etc
	doins bin/my_rules_du_jour.conf bin/my_rules_du_jour.rulesets
	insinto $SPAMASSASSIN_CONFDIR
	doins rules/*
	insinto /etc/cron.daily
	newins cron-myrulesdujour myrulesdujour
	fperms 644 /etc/cron.daily/myrulesdujour
}

pkg_postinst() {
	einfo "If you want RulesDuJour to run automatically, be sure to"
	einfo "chmod +x /etc/cron.daily/myrulesdujour"
}
