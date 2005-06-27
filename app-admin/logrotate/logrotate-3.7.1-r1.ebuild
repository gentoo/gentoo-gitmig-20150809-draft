# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.7.1-r1.ebuild,v 1.5 2005/06/27 18:53:29 gustavoz Exp $

inherit eutils

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 sparc x86"
IUSE="selinux"

RDEPEND="
	>=dev-libs/popt-1.5
	selinux? ( sys-libs/libselinux )"

DEPEND="${DEPEND}
	>=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4
	selinux? ( sec-policy/selinux-logrotate )"

src_unpack() {
	unpack ${P}.tar.bz2

	cd ${S}

	sed -i \
		-e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" \
		-e "/CVSROOT =/d" \
		Makefile || die "sed failed"

	epatch ${FILESDIR}/${P}-dateext-maxage.patch
	epatch ${FILESDIR}/${P}-datehack.patch
	epatch ${FILESDIR}/${P}-ignore-hidden.patch
	epatch ${FILESDIR}/${P}-manpage-fixes.patch
	epatch ${FILESDIR}/${P}-taboo-to-debug.patch
	epatch ${FILESDIR}/${P}-no-tmpdir.patch
}

src_compile() {
	local myconf
	useq selinux && myconf='WITH_SELINUX=yes'
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
	einfo "If you wish to have logrotate e-mail you updates, please"
	einfo "emerge mail-client/mailx and configure logrotate in"
	einfo "/etc/logrotate.conf appropriately"
	einfo
	einfo "Additionally, /etc/logrotate.conf may need to be modified"
	einfo "for your particular needs.  See man logrotate for details."
}
