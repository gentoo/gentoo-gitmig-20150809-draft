# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/checkpw/checkpw-1.01.ebuild,v 1.1 2004/03/11 15:33:14 matsuu Exp $

inherit gcc

DESCRIPTION="an implementation of the checkpassword interface that checks a password"
HOMEPAGE="http://checkpw.sourceforge.net/checkpw/"
SRC_URI="mirror://sourceforge/checkpw/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
IUSE="static"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~amd64 ~ia64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# the -s is from the original build
	LDFLAGS="${LDFLAGS} -s"
	use static && LDFLAGS="${LDFLAGS} -static"
	echo "$(gcc-getCC) ${CFLAGS}" > conf-cc || die
	echo "$(gcc-getCC) ${LDFLAGS}" > conf-ld || die
	echo ".maildir" > conf-maildir || die

	if [ -z "$QMAIL_HOME" ]; then
		QMAIL_HOME="/var/qmail"
		ewarn "QMAIL_HOME is null! Using default."
		ewarn "Create the qmail user and set the homedir to your desired location."
	fi
	einfo "Using $QMAIL_HOME as qmail's default home directory."
	echo ${QMAIL_HOME} > conf-qmail || die

	sed -i -e 's/head -1/head -n 1/g' Makefile auto_*.do default.do || die
}

src_compile() {
	emake || die
}

src_install() {
	into /
	dobin checkpw checkapoppw selectcheckpw loginlog
	fperms 0700 /bin/checkpw /bin/checkapoppw /bin/selectcheckpw

	dodoc CHANGES INSTALL README
	docinto samples
	dodoc run-{apop,both,multidir,multipw,pop,rules}
}

pkg_postinst() {
	einfo
	einfo "How to set password:"
	einfo
	einfo " % echo 'YOURPASSWORD' > ~/.maildir/.password"
	einfo " % chmod 600 ~/.maildir/.password"
	einfo
	einfo "Replace YOURPASSWORD with your plain password."
	einfo
}
