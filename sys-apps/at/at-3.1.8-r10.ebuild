# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/at/at-3.1.8-r10.ebuild,v 1.1 2004/01/25 23:18:27 vapier Exp $

DESCRIPTION="Queues jobs for later execution"
HOMEPAGE="ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/"
SRC_URI="http://ftp.debian.org/debian/pool/main/a/at/at_${PV}-11.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64 ~ppc64"

DEPEND="virtual/glibc
	>=sys-devel/flex-2.5.4a"
RDEPEND="virtual/glibc
	virtual/mta"

src_compile() {
	./configure \
		--host=${CHOST/-pc/} \
		--sysconfdir=/etc/at \
		--with-jobdir=/var/spool/at/atjobs \
		--with-atspool=/var/spool/at/atspool \
		--with-etcdir=/etc/at \
		--with-daemon_username=at \
		--with-daemon_groupname=at || die
	emake || die
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

	dodir /var/spool/at
	fowners at:at /var/spool/at
	for i in atjobs atspool
	do
		dodir /var/spool/at/${i}
		fowners at:at /var/spool/at/${i}
		fperms 700 /var/spool/at/${i}
		touch ${D}/var/spool/at/${i}/.SEQ
	done

	exeinto /etc/init.d
	newexe ${FILESDIR}/atd.rc6 atd
	insinto /etc/at
	insopts -m 0644
	doins ${FILESDIR}/at.deny
	doman at.1 at_allow.5 atd.8 atrun.8
	dodoc COPYING ChangeLog Copyright Problems README timespec
}
