# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fcron/fcron-2.0.0-r1.ebuild,v 1.15 2003/06/21 21:19:39 drobbins Exp $

DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
KEYWORDS="x86 amd64 -ppc sparc "

S=${WORKDIR}/${P}
SRC_URI="http://fcron.free.fr/${P}.src.tar.gz"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

RDEPEND="!virtual/cron
	sys-apps/cronbase
	virtual/mta"

PROVIDE="virtual/cron"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die "bad patchfile"
	# fix LIBOBJS vs AC_LIBOBJ problem
	mv configure.in configure.in~
	sed <configure.in~ >configure.in -e 's|LIBOBJS|AC_LIBOBJ|g'
	autoconf || die "autoconf problem"
}

src_compile() {

	./configure \
		--prefix=/usr \
		--with-username=cron \
		--with-groupname=cron \
		--with-piddir=/var/run \
		--with-etcdir=/etc/fcron \
		--with-spooldir=/var/spool/cron \
		--with-sendmail=/usr/sbin/sendmail \
		--with-editor=/usr/bin/nano \
		--with-cflags="${CFLAGS}" --host=${CHOST} || die "bad configure"

	emake || die "compile problem"
}

src_install() {

	# this does not work if the directory already exist
	diropts -m 770 -o cron -g cron
	dodir /var/spool/cron/fcrontabs

	insinto /usr/sbin
	insopts -o root -g root -m 0110 ; doins fcron

	insinto /usr/bin
	insopts -o cron -g cron -m 6110 ; doins fcrontab
	insopts -o root -g cron -m 6110 ; doins fcronsighup

	dosym fcrontab /usr/bin/crontab

	doman doc/*.{1,3,5,8}

	dodoc MANIFEST VERSION doc/{CHANGES,README,LICENSE,FAQ,INSTALL,THANKS}
	newdoc ${FILESDIR}/fcron.conf fcron.conf.sample
	docinto html ; dohtml doc/*.html

	insinto /etc/fcron
	insopts -m 640 -o root -g cron
	doins ${FILESDIR}/{fcron.allow,fcron.deny,fcron.conf}

	exeinto /etc/init.d ; newexe ${FILESDIR}/fcron.rc6 fcron

	insinto /etc
	doins ${FILESDIR}/crontab

	dodoc ${FILESDIR}/crontab
}

pkg_postinst() {

	echo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	echo
	einfo "!!! That will replace root's current crontab !!!"
	echo
}
