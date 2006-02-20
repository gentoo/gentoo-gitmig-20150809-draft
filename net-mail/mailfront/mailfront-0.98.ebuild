# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailfront/mailfront-0.98.ebuild,v 1.1 2006/02/20 21:46:30 hansmi Exp $

inherit toolchain-funcs

DESCRIPTION="Mail server network protocol front-ends"
HOMEPAGE="http://untroubled.org/mailfront/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="
	virtual/libc
	>=dev-libs/bglibs-1.022
	>=net-libs/cvm-0.71
"
RDEPEND="
	${DEPEND}
	virtual/qmail
	net-libs/cvm
"

src_compile() {
	echo "/usr/include/bglibs/" > conf-bgincs
	echo "/usr/lib/bglibs/" > conf-bglibs
	echo "/var/qmail/bin" > conf-bin
	echo "/var/qmail" > conf-qmail
	echo "${D}/var/qmail/bin" > conf-bin
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) -s" > conf-ld
	make || die
}

src_install() {
	dodir /var/qmail/bin
	emake install || die

	exeinto /var/qmail/supervise/qmail-smtpd
	newexe ${FILESDIR}/run-smtpfront run.mailfront
	exeinto /var/qmail/supervise/qmail-pop3d
	newexe ${FILESDIR}/run-pop3front run.mailfront

	dodoc ANNOUNCEMENT COPYING ChangeLog NEWS README VERSION
	dohtml *.html
}

pkg_config() {
	cd /var/qmail/supervise/qmail-smtpd/
	cp run run.qmail-smtpd.`date +%Y%m%d%H%M%S` && cp run.mailfront run
	cd /var/qmail/supervise/qmail-pop3d/
	cp run run.qmail-pop3d.`date +%Y%m%d%H%M%S` && cp run.mailfront run
}

pkg_postinst() {
	echo
	einfo "Run "
	einfo "emerge --config =${PF}"
	einfo "to update your run files (backups are created) in"
	einfo "		/var/qmail/supervise/qmail-pop3d and"
	einfo "		/var/qmail/supervise/qmail-smtpd"
	echo
}
