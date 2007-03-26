# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.7.2.ebuild,v 1.13 2007/03/26 07:28:20 antarus Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="selinux"

RDEPEND="
	>=dev-libs/popt-1.5
	selinux? ( sys-libs/libselinux )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	selinux? ( sec-policy/selinux-logrotate )"

src_unpack() {
	unpack ${P}.tar.bz2

	cd ${S}

	sed -i \
		-e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" \
		-e "/CVSROOT =/d" \
		Makefile || die "sed failed"
}

src_compile() {
	local myconf
	myconf="CC=$(tc-getCC)"
	useq selinux && myconf="${myconf} WITH_SELINUX=yes"
	emake ${myconf} || die "emake failed"
}

src_install() {
	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc examples/logrotate*

	exeinto /etc/cron.daily
	doexe ${FILESDIR}/logrotate.cron

	insinto /etc
	doins ${FILESDIR}/logrotate.conf

	keepdir /etc/logrotate.d
}

pkg_postinst() {
	elog "If you wish to have logrotate e-mail you updates, please"
	elog "emerge mail-client/mailx and configure logrotate in"
	elog "/etc/logrotate.conf appropriately"
	elog
	elog "Additionally, /etc/logrotate.conf may need to be modified"
	elog "for your particular needs.  See man logrotate for details."
}
