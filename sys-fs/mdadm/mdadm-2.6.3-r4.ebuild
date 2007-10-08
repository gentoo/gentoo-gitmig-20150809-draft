# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mdadm/mdadm-2.6.3-r4.ebuild,v 1.1 2007/10/08 21:07:06 robbat2 Exp $

inherit eutils flag-o-matic

DESCRIPTION="A useful tool for running RAID systems - it can be used as a replacement for the raidtools"
HOMEPAGE="http://cgi.cse.unsw.edu.au/~neilb/mdadm"
SRC_URI="mirror://kernel/linux/utils/raid/mdadm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="static"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.9.0-dont-make-man.patch
	epatch "${FILESDIR}"/${PN}-2.6-syslog-updates.patch
	use static && append-ldflags -static
}

src_compile() {
	emake \
		CROSS_COMPILE=${CHOST}- \
		CWFLAGS="-Wall" \
		CXFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	exeinto /$(get_libdir)/rcscripts/addons
	newexe "${FILESDIR}"/raid-start.sh-2.6.3-r4 raid-start.sh || die "addon failed"
	newexe "${FILESDIR}"/raid-stop.sh-2.6.3-r2 raid-stop.sh || die "addon failed"
	dodoc INSTALL TODO "ANNOUNCE-${PV}"

	insinto /etc
	newins mdadm.conf-example mdadm.conf
	newinitd "${FILESDIR}"/mdadm.rc mdadm || die "installing mdadm.rc failed"
	newconfd "${FILESDIR}"/mdadm.confd mdadm || die "installing mdadm.confd failed"
	newinitd "${FILESDIR}"/mdraid.rc-2.6.3-r4 mdraid || die "installing mdraid.rc failed"

	insinto /etc/udev/rules.d/
	newins "${FILESDIR}"/64-md-raid.rules-2.6.3-r2 64-md-raid.rules || die
}

pkg_postinst() {
	elog "If using baselayout-2 and not relying on kernel auto-detect"
	elog "of your RAID devices, you need to add 'mdraid' to your 'boot'"
	elog "runlevel. Run the following command:"
	elog "rc-update add mdraid boot"
}
