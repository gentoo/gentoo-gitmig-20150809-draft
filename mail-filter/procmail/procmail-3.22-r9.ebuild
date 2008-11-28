# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/procmail/procmail-3.22-r9.ebuild,v 1.3 2008/11/28 21:45:21 maekke Exp $

inherit eutils flag-o-matic

DESCRIPTION="Mail delivery agent/filter"
HOMEPAGE="http://www.procmail.org/"
SRC_URI="http://www.procmail.org/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="mbox selinux"

DEPEND="virtual/libc virtual/mta"
RDEPEND="virtual/libc
	selinux? ( sec-policy/selinux-procmail )"
PROVIDE="virtual/mda"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable flock, using both fcntl and flock style locking
	# doesn't work with NFS with 2.6.17+ kernels, bug #156493

	sed -e "s:/\*#define NO_flock_LOCK:#define NO_flock_LOCK:" \
		-i config.h || die "sed failed"

	if ! use mbox ; then
		echo "# Use maildir-style mailbox in user's home directory" > "${S}"/procmailrc
		echo 'DEFAULT=$HOME/.maildir/' >> "${S}"/procmailrc
		cd "${S}"
		epatch "${FILESDIR}/gentoo-maildir3.diff"
	else
		echo '# Use mbox-style mailbox in /var/spool/mail' > "${S}"/procmailrc
		echo 'DEFAULT=/var/spool/mail/$LOGNAME' >> "${S}"/procmailrc
	fi

	# Do not use lazy bindings on lockfile and procmail
	epatch "${FILESDIR}/${PN}-lazy-bindings.diff"

	# Fix for bug #102340
	epatch "${FILESDIR}/${PN}-comsat-segfault.diff"

	# Fix for bug #119890
	epatch "${FILESDIR}/${PN}-maxprocs-fix.diff"

	# Fix for bug #200006
	epatch "${FILESDIR}/${PN}-pipealloc.diff"
}

src_compile() {
	# -finline-functions (implied by -O3) leaves strstr() in an infinite loop.
	# To work around this, we append -fno-inline-functions to CFLAGS
	append-flags -fno-inline-functions

	sed -e "s:CFLAGS0 = -O:CFLAGS0 = ${CFLAGS}:" \
		-e "s:LOCKINGTEST=__defaults__:#LOCKINGTEST=__defaults__:" \
		-e "s:#LOCKINGTEST=/tmp:LOCKINGTEST=/tmp:" \
		-i Makefile || die "sed failed"

	emake || die
}

src_install() {
	cd "${S}"/new
	insinto /usr/bin
	insopts -m 6755
	doins procmail || die

	doins lockfile || die
	fowners root:mail /usr/bin/lockfile
	fperms 2775 /usr/bin/lockfile

	dobin formail mailstat || die
	insopts -m 0644

	doman *.1 *.5

	cd "${S}"
	dodoc Artistic FAQ FEATURES HISTORY INSTALL KNOWN_BUGS README

	insinto /etc
	doins procmailrc || die

	docinto examples
	dodoc examples/*
}
