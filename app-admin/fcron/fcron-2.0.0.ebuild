# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>, Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/fcron/fcron-2.0.0.ebuild,v 1.2 2001/11/27 07:21:34 woodchip Exp $

DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"

S=${WORKDIR}/${P}
SRC_URI="http://fcron.free.fr/${P}.src.tar.gz"

DEPEND="virtual/glibc virtual/mta"

src_unpack() {

	unpack ${A} ; cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die "bad patchfile"
	autoconf || die "autoconf problem"
}

src_compile() {

	./configure \
	--prefix=/usr \
	--with-username=cron \
	--with-groupname=cron \
	--with-piddir=/var/run \
	--with-etcdir=/etc/fcron \
	--with-spooldir=/var/spool/fcron \
	--with-sendmail=/usr/sbin/sendmail \
	--with-cflags="${CFLAGS}" --host=${CHOST} || die "bad configure"

	emake || die "compile problem"
}

src_install() {

	diropts -m 755 -o root -g root ; dodir /var/spool
	diropts -m 770 -o cron -g cron ; dodir /var/spool/fcron

	insinto /usr/sbin
	insopts -o root -g root -m 0110 ; doins fcron

	insinto /usr/bin
	insopts -o cron -g cron -m 6111 ; doins fcrontab
	insopts -o root -g root -m 6111 ; doins fcronsighup

	doman doc/*.{1,3,5,8}

	dodoc MANIFEST VERSION doc/{CHANGES,README,LICENSE,FAQ,INSTALL,THANKS}
	newdoc files/fcron.conf fcron.conf.sample
	docinto html ; dodoc doc/*.html

	insinto /etc/fcron
	insopts -m 640 -o root -g cron ; doins files/{fcron.allow,fcron.deny}
	newins files/fcron.conf fcron.conf.sample

	exeinto /etc/init.d ; newexe ${FILESDIR}/fcron.rc6 fcron
}
