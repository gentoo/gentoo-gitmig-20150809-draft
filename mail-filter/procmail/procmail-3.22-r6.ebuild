# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/procmail/procmail-3.22-r6.ebuild,v 1.10 2004/11/08 08:53:23 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Mail delivery agent/filter"
HOMEPAGE="http://www.procmail.org/"
SRC_URI="http://www.procmail.org/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips s390 ppc64"
IUSE="mbox"
PROVIDE="virtual/mda"

DEPEND="virtual/libc !mail-mta/courier virtual/mta"
RDEPEND="virtual/libc"

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

	if ! use mbox;
	then
		echo "# Use maildir-style mailbox in user's home directory" > ${S}/procmailrc
		echo 'DEFAULT=$HOME/.maildir/' >> ${S}/procmailrc
		cd ${S}
		epatch ${FILESDIR}/gentoo-maildir2.diff
	else
		echo '# Use mbox-style mailbox in /var/spool/mail' > ${S}/procmailrc
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
