# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/at/at-3.1.8-r11.ebuild,v 1.5 2007/03/26 08:03:22 antarus Exp $

inherit eutils flag-o-matic

DESCRIPTION="Queues jobs for later execution"
HOMEPAGE="ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/"
SRC_URI="http://ftp.debian.org/debian/pool/main/a/at/at_${PV}-11.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-devel/flex-2.5.4a"
RDEPEND="virtual/libc
	virtual/mta"

pkg_setup() {
	enewgroup at 25
	enewuser at 25 -1 /var/spool/cron/atjobs at
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# respect LDFLAGS
	sed -i \
		-e "s/\(@LIBS@\)/@LDFLAGS@ \1/" \
		Makefile.in || die "sed Makefile.in failed"

	# Fix bug 33696 by allowing usernames longer than 8 chars,
	# thanks to Yuval Kogman for the patch
	epatch ${FILESDIR}/at-3.1.8-longuser.patch
}

src_compile() {
	./configure \
		--host=${CHOST/-pc/} \
		--sysconfdir=/etc/at \
		--with-jobdir=/var/spool/at/atjobs \
		--with-atspool=/var/spool/at/atspool \
		--with-etcdir=/etc/at \
		--with-daemon_username=at \
		--with-daemon_groupname=at \
		${EXTRA_ECONF} || die "configure failed"

	emake LDFLAGS="${LDFLAGS}" || die "make failed"
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
	for i in atjobs atspool ; do
		dodir /var/spool/at/${i}
		fowners at:at /var/spool/at/${i}
		fperms 700 /var/spool/at/${i}
		touch ${D}/var/spool/at/${i}/.SEQ
	done

	newinitd ${FILESDIR}/atd.rc6 atd
	insinto /etc/at
	insopts -m 0644
	doins ${FILESDIR}/at.deny
	doman at.1 at_allow.5 atd.8 atrun.8
	dodoc ChangeLog Problems README timespec
}
