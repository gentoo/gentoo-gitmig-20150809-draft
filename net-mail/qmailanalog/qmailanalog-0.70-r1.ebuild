# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmailanalog/qmailanalog-0.70-r1.ebuild,v 1.5 2004/07/15 01:52:53 agriffis Exp $

inherit eutils fixheadtails

DESCRIPTION="collection of tools to help you analyze qmail's activity record"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/qmailanalog.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="sys-apps/groff"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
	ht_fix_file auto_home.c.do default.do Makefile
}

src_compile() {
	echo "/var/qmail" > conf-home
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld

	emake || die
	gcc ${CFLAGS} ${FILESDIR}/tai64nfrac.c -o tai64nfrac || die
}

src_install() {
	doman matchup.1 xqp.1 xsender.1 xrecipient.1 columnt.1
	dodoc MATCHUP ACCOUNTING BLURB

	insopts -o root -g qmail -m 755
	insinto /var/qmail/bin
	into /var/qmail
	dobin columnt ddist deferrals failures matchup recipients rhosts
	dobin rxdelay senders successes suids xqp xrecipient xsender
	dobin zddist zdeferrals zfailures zoverall zrecipients zrhosts
	dobin zrxdelay zsenders zsendmail zsuccesses zsuids tai64nfrac
}
