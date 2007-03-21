# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/dcron/dcron-3.2.ebuild,v 1.9 2007/03/21 14:17:33 wolf31o2 Exp $

inherit cron toolchain-funcs

DESCRIPTION="A cute little cron from Matt Dillon"
HOMEPAGE="http://apollo.backplane.com/FreeSrc/"
SRC_URI="http://apollo.backplane.com/FreeSrc/${PN}${PV//.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=sys-apps/portage-2.0.51"
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
	emake CC="$(tc-getCC)" || die
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
