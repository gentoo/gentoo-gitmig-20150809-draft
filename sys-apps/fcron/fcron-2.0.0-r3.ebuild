# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fcron/fcron-2.0.0-r3.ebuild,v 1.2 2003/04/21 17:00:58 gmsoft Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/${P}.src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc ~sparc hppa"

DEPEND="virtual/editor"
RDEPEND="!virtual/cron sys-apps/cronbase virtual/mta"
PROVIDE="virtual/cron"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	# fix LIBOBJS vs AC_LIBOBJ problem
	mv configure.in configure.in~
	sed <configure.in~ >configure.in -e 's|LIBOBJS|AC_LIBOBJ|g'
	autoconf || die "autoconf problem"
}

src_compile() {
	econf \
		--with-username=cron \
		--with-groupname=cron \
		--with-piddir=/var/run \
		--with-etcdir=/etc/fcron \
		--with-spooldir=/var/spool/cron \
		--with-sendmail=/usr/sbin/sendmail \
		--with-editor="${EDITOR}" \
		--with-cflags="${CFLAGS}" || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
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
	dodoc ${FILESDIR}/crontab

	insinto /etc/fcron
	insopts -m 640 -o root -g cron
	doins ${FILESDIR}/{fcron.allow,fcron.deny,fcron.conf}

	exeinto /etc/init.d
	newexe ${FILESDIR}/fcron.rc6 fcron

	insinto /etc
	doins ${FILESDIR}/crontab
}

pkg_postinst() {
	# empty dir
	install -m0770 -o cron -g cron -d ${ROOT}/var/spool/cron/fcrontabs

	einfo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	einfo
	einfo "!!! That will replace root's current crontab !!!"
	einfo
}
