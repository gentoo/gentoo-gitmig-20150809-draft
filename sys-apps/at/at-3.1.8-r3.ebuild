# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/at/at-3.1.8-r3.ebuild,v 1.13 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="queues jobs for later execution"
SRC_URI="ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/${P}.tar.bz2
	 ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/${P}.dif"
HOMEPAGE="ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/"
KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc >=sys-devel/flex-2.5.4a"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${DISTDIR}/${P}.dif || die
	cp configure.in configure.orig
	patch -p0 < ${FILESDIR}/${P}-configure.in-sendmail-gentoo.diff || die
	patch -p0 < ${FILESDIR}/${P}-configure-sendmail-gentoo.diff || die
}

src_compile() {
	./configure --host=${CHOST/-pc/} --sysconfdir=/etc/at \
		--with-jobdir=/var/cron/atjobs \
		--with-atspool=/var/cron/atspool \
		--with-etcdir=/etc/at \
		--with-daemon_username=at \
		--with-daemon_groupname=at
	assert

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

	for i in atjobs atspool
	do
		dodir /var/cron/${i}
		fperms 700 /var/cron/${i}
		fowners at.at /var/cron/${i}
		touch ${D}/var/cron/${i}/.SEQ
	done

	exeinto /etc/rc.d/init.d
	newexe ${FILESDIR}/atd.rc5 atd
	insinto /etc/at
	insopts -m 0644
	doins ${FILESDIR}/at.deny
	doman at.1 at_allow.5 atd.8 atrun.8
	dodoc COPYING ChangeLog Copyright Problems README
}
