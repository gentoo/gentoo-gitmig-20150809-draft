# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/at/at-3.1.8-r10.ebuild,v 1.8 2004/11/13 01:00:47 ka0ttic Exp $

inherit eutils flag-o-matic

DESCRIPTION="Queues jobs for later execution"
HOMEPAGE="ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/"
SRC_URI="mirror://debian/pool/main/a/at/at_${PV}-11.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~amd64 ~ia64 ~ppc64"
IUSE=""

DEPEND="virtual/libc
	>=sys-devel/flex-2.5.4a"
RDEPEND="virtual/libc
	virtual/mta"

src_unpack() {
	unpack ${A} && cd ${S} || die "error unpacking"

	# respect LDFLAGS
	sed -i "s/\(@LIBS@\)/@LDFLAGS@ \1/" Makefile.in || \
		die "sed Makefile.in failed"

	# Fix bug 33696 by allowing usernames longer than 8 chars,
	# thanks to Yuval Kogman for the patch
	epatch ${FILESDIR}/at-3.1.8-longuser.patch
}

src_compile() {
	# QA security notice fix; see "[gentoo-core] Heads up changes in suid
	# handling with portage >=51_pre21" for more details.
	append-ldflags -Wl,-z,now

	./configure --host=${CHOST/-pc/} --sysconfdir=/etc/at \
		--with-jobdir=/var/cron/atjobs \
		--with-atspool=/var/cron/atspool \
		--with-etcdir=/etc/at \
		--with-daemon_username=at \
		--with-daemon_groupname=at || die

	emake LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	into /usr
	chmod 755 batch
	chmod 755 atrun
	dobin at batch
	fperms 4755 /usr/bin/at
	dosym at /usr/bin/atrm
	dosym at /usr/bin/atq
	dosbin atd atrun

	for i in atjobs atspool
	do
		dodir /var/cron/${i}
		fowners at:at /var/cron/${i}
		fperms 700 /var/cron/${i}
		touch ${D}/var/cron/${i}/.SEQ
	done

	exeinto /etc/init.d
	newexe ${FILESDIR}/atd.rc6 atd
	insinto /etc/at
	insopts -m 0644
	doins ${FILESDIR}/at.deny
	doman at.1 at_allow.5 atd.8 atrun.8
	dodoc COPYING ChangeLog Copyright Problems README timespec
}
