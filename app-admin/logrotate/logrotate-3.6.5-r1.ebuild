# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.6.5-r1.ebuild,v 1.19 2005/05/30 03:31:34 kumba Exp $

inherit eutils

SELINUX_PATCH="logrotate-3.6.5-selinux.diff.bz2"

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="http://packages.debian.org/unstable/admin/logrotate.html"
SRC_URI="mirror://debian/pool/main/l/logrotate/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ia64 amd64 ppc64 s390 hppa mips"
IUSE="selinux"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=dev-libs/popt-1.5
	>=sys-apps/sed-4
	selinux? ( sys-libs/libselinux )"

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-logrotate )"

src_unpack() {
	unpack ${PN}_${PV}.orig.tar.gz

	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}

	sed -i \
		-e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" \
		-e "/CVSROOT =/d" \
		${S}/Makefile || die "sed failed"

	#small fix for a tipo in man page
	sed -i -e "s:logrotate/status:logrotate.status:" ${S}/logrotate.8 || die \
		"sed failed!"
}

src_compile() {
	emake || die "emake failed"
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
