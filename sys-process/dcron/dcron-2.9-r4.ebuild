# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/dcron/dcron-2.9-r4.ebuild,v 1.5 2007/03/26 08:01:58 antarus Exp $

inherit cron toolchain-funcs

DESCRIPTION="A cute little cron from Matt Dillon"
HOMEPAGE="http://apollo.backplane.com/"
SRC_URI="http://apollo.backplane.com/FreeSrc/${PN}${PV//.}.tgz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/dcron-2.9-Makefile.patch
	epatch "${FILESDIR}"/dcron-2.9-pidfile.patch
	epatch "${FILESDIR}"/dcron-2.9-EDITOR.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	docrondir
	docron crond -m0700 -o root -g wheel
	docrontab

	dodoc CHANGELOG README "${FILESDIR}"/crontab
	doman crontab.1 crond.8

	newinitd "${FILESDIR}"/dcron.init dcron
	newconfd "${FILESDIR}"/dcron.confd dcron

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/dcron.logrotate dcron

	insinto /etc
	doins "${FILESDIR}"/crontab
}
