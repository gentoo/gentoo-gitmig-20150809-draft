# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mdadm/mdadm-3.1.1.ebuild,v 1.2 2009/11/30 22:01:15 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="A useful tool for running RAID systems - it can be used as a replacement for the raidtools"
HOMEPAGE="http://neil.brown.name/blog/mdadm"
SRC_URI="mirror://kernel/linux/utils/raid/mdadm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="static"

DEPEND=""
RDEPEND=">=sys-apps/util-linux-2.16"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-3.0-dont-make-man.patch
	epatch "${FILESDIR}"/${PN}-2.6-syslog-updates.patch
	epatch "${FILESDIR}"/${PN}-2.6.4-mdassemble.patch #211426
	use static && append-ldflags -static
}

src_compile() {
	emake \
		CROSS_COMPILE=${CHOST}- \
		CWFLAGS="-Wall" \
		CXFLAGS="${CFLAGS}" \
		all mdassemble \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	into /
	dosbin mdassemble || die
	dodoc ChangeLog INSTALL TODO README* ANNOUNCE-${PV}

	exeinto /$(get_libdir)/rcscripts/addons
	newexe "${FILESDIR}"/raid-start.sh-3.0 raid-start.sh || die "addon failed"
	newexe "${FILESDIR}"/raid-stop.sh raid-stop.sh || die "addon failed"

	insinto /etc
	newins mdadm.conf-example mdadm.conf
	newinitd "${FILESDIR}"/mdadm.rc mdadm || die "installing mdadm.rc failed"
	newconfd "${FILESDIR}"/mdadm.confd mdadm || die "installing mdadm.confd failed"
	newinitd "${FILESDIR}"/mdraid.rc mdraid || die "installing mdraid.rc failed"
}

pkg_postinst() {
	elog "If using baselayout-2 and not relying on kernel auto-detect"
	elog "of your RAID devices, you need to add 'mdraid' to your 'boot'"
	elog "runlevel. Run the following command:"
	elog "rc-update add mdraid boot"
}
