# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/procmail/procmail-3.22-r5.ebuild,v 1.14 2004/01/06 00:38:16 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mail delivery agent/filter"
SRC_URI="http://www.procmail.org/${P}.tar.gz"
HOMEPAGE="http://www.procmail.org/"

IUSE=""

DEPEND="virtual/glibc
	virtual/mta"

RDEPEND="virtual/glibc"

PROVIDE="virtual/mda"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha arm hppa"

src_compile() {

	cp Makefile Makefile.orig
# Added a -O2 at the end of CFLAGS to overcome what seems to be a
# gcc-3.1 strstr() bug with more aggressive optimization flags
# The order of the flags matters as the last flag passed clobbers
# the first flag.  i.e. if -O2 was placed before ${CFLAGS},
# whatever optimization that is in ${CFLAGS} would clobber -O2
	sed -e "s:CFLAGS0 = -O:CFLAGS0 = ${CFLAGS} -O2:" \
		-e "s:LOCKINGTEST=__defaults__:#LOCKINGTEST=__defaults__:" \
		-e "s:#LOCKINGTEST=/tmp:LOCKINGTEST=/tmp:" Makefile.orig > Makefile

	if [ -z "`use mbox`" ];
	then
		echo "# Use maildir-style mailbox in user's home directory" > ${S}/procmailrc
		echo 'DEFAULT=$HOME/.maildir/' >> ${S}/procmailrc
		cd ${S}
		patch -p1 <${FILESDIR}/gentoo-maildir.diff

	else
		echo '# Use mbox-style mailbox in /var/spool/mail' > ${S}/procmail
		echo 'DEFAULT=/var/spool/mail/$LOGNAME' >> ${S}/procmailrc
	fi

	emake || die
}

src_install () {
	cd ${S}/new
	insinto /usr/bin
	insopts -m 6755
	doins procmail

	insopts -m 2755
	doins lockfile

	dobin formail mailstat

	doman *.1 *.5

	cd ${S}
	dodoc Artistic COPYING FAQ FEATURES HISTORY INSTALL KNOWN_BUGS README

	insinto /etc
	doins procmailrc

	docinto examples
	dodoc examples/*
}

