# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fcron/fcron-2.9.4.ebuild,v 1.4 2004/09/03 21:03:23 pvdabeel Exp $

inherit eutils

DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/archives/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips ~hppa ~amd64"
IUSE="pam doc selinux"

DEPEND="virtual/editor
	doc? ( >=app-text/docbook-dsssl-stylesheets-1.77 )
	selinux? ( sys-libs/libselinux )
	pam? ( >=sys-libs/pam-0.77 )"
RDEPEND="!virtual/cron
	>=sys-apps/cronbase-0.2.1-r3
	virtual/mta"
PROVIDE="virtual/cron"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-braindead-configure-check.patch
	use selinux && epatch ${FILESDIR}/fcron-2.9.4-selinuxupdate.diff
	autoconf || die "autoconf failed"
}

src_compile() {
	local myconf=
	use pam \
		&& myconf="${myconf} --with-pam=yes" \
		|| myconf="${myconf} --with-pam=no"
	use doc && myconf="${myconf} --with-dsssl-dir=/usr/share/sgml/stylesheets/dsssl/docbook"
	use selinux \
		&& myconf="${myconf} --with-selinux=yes" \
		|| myconf="${myconf} --with-selinux=no"
	econf \
		--with-username=cron \
		--with-groupname=cron \
		--with-piddir=/var/run \
		--with-etcdir=/etc/fcron \
		--with-spooldir=/var/spool/cron \
		--with-fifodir=/var/run \
		--with-sendmail=/usr/sbin/sendmail \
		--with-fcrondyn=yes \
		--with-editor=${EDITOR} \
		--with-cflags="${CFLAGS}" \
		${myconf} \
		|| die "Configure problem"

	emake || die "Compile problem"
}

src_install() {
	dodir /var/spool
	diropts -m 0770 -o cron -g cron
	keepdir /var/spool/cron/fcrontabs

	insinto /usr/sbin
	insopts -o root -g root -m0110 ; doins fcron
	insinto /usr/bin
	insopts -o cron -g cron -m6110 ; doins fcrontab fcrondyn
	insopts -o root -g cron -m6110 ; doins fcronsighup
	dosym fcrontab /usr/bin/crontab

	insinto /etc/fcron
	insopts -m 640 -o root -g cron
	doins ${FILESDIR}/{fcron.allow,fcron.deny,fcron.conf}

	insopts -m 644 -o root -g root
	if use pam ; then
		insinto /etc/pam.d
		newins ${FILESDIR}/fcron.pam fcron
		newins ${FILESDIR}/fcrontab.pam fcrontab
	fi
	insinto /etc
	doins ${FILESDIR}/crontab

	exeinto /etc/init.d
	newexe ${FILESDIR}/fcron.rc6 fcron

	dodoc MANIFEST VERSION doc/txt/*.txt
	newdoc ${FILESDIR}/fcron.conf-${PV} fcron.conf.sample
	if use doc ; then
		docinto html ; dohtml doc/HTML/*.html
	fi
	dodoc ${FILESDIR}/crontab

	doman doc/man/*.{1,3,5,8}
}

pkg_postinst() {
	einfo "Each user who uses fcron should be added to the cron group"
	einfo "in /etc/group and also be added in /etc/fcron/fcron.allow"
	einfo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	einfo
	einfo "!!! That will replace root's current crontab !!!"
	einfo
}
