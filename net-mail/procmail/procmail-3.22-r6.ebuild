# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/procmail/procmail-3.22-r6.ebuild,v 1.7 2004/01/29 21:34:01 blkdeath Exp $

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
KEYWORDS="x86 ppc sparc alpha arm hppa amd64 ia64 ~mips"

src_compile() {

# With gcc-3.1 and newer, there is a bug with aggressive optimization caused by
# -finline-functions (implied by -O3) that leaves strstr() is an infinite loop.
# To work around this, we append -fno-inline-functions to CFLAGS disable just
# that optimization and avoid the bug.
	CFLAGS="${CFLAGS} -fno-inline-functions"
	sed -e "s:CFLAGS0 = -O:CFLAGS0 = ${CFLAGS}:" \
		-e "s:LOCKINGTEST=__defaults__:#LOCKINGTEST=__defaults__:" \
		-e "s:#LOCKINGTEST=/tmp:LOCKINGTEST=/tmp:" \
		-i Makefile

	if [ -z "`use mbox`" ];
	then
		echo "# Use maildir-style mailbox in user's home directory" > ${S}/procmailrc
		echo 'DEFAULT=$HOME/.maildir/' >> ${S}/procmailrc
		cd ${S}
		patch -p1 <${FILESDIR}/gentoo-maildir2.diff
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
	insopts -m 0644

	doman *.1 *.5

	cd ${S}
	dodoc Artistic COPYING FAQ FEATURES HISTORY INSTALL KNOWN_BUGS README

	insinto /etc
	doins procmailrc

	docinto examples
	dodoc examples/*
}

