# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# Modified by $HOME/.maildir by Craig Joly <craig@taipan.mudshark.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/procmail/procmail-3.22-r2.ebuild,v 1.1 2002/06/18 14:40:42 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mail delivery agent/filter"
SRC_URI="http://www.procmail.org/${P}.tar.gz"
HOMEPAGE="http://www.procmail.org/"

DEPEND="virtual/glibc
        virtual/mta"

src_compile() {

    cp Makefile Makefile.orig
    sed -e "s:CFLAGS0 = -O:CFLAGS0 = ${CFLAGS}:" \
        -e "s:LOCKINGTEST=__defaults__:#LOCKINGTEST=__defaults__:" \
        -e "s:#LOCKINGTEST=/tmp:LOCKINGTEST=/tmp:" Makefile.orig > Makefile

    if [ -z "`use mbox`" ];
    then
		echo "# Use maildir-style mailbox in user's home directory" > ${S}/procmailrc
		echo 'DEFAULT=$HOME/.maildir/' >> ${S}/procmailrc
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

