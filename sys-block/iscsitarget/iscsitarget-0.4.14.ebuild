# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/iscsitarget/iscsitarget-0.4.14.ebuild,v 1.1 2006/12/27 02:28:40 robbat2 Exp $

inherit linux-mod eutils

DESCRIPTION="Open Source iSCSI target with professional features"
HOMEPAGE="http://iscsitarget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
		virtual/linux-sources"
MODULE_NAMES="iscsi_trgt(kernel/iscsi:${S}/kernel)"
CONFIG_CHECK="CRYPTO_CRC32C"
ERROR_CFG="iscsitarget needs support for CRC32C in your kernel."

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S} -p0" \
	epatch ${FILESDIR}/${PN}-0.4.13-usrbuildfix.patch
	epatch ${FILESDIR}/${PN}-0.4.14-isns-compilefix.patch
	convert_to_m ${S}/Makefile
}

src_compile() {
	einfo "Building userspace"
	CFLAGS="" emake progs OPTFLAGS="${CFLAGS}" || die "failed to build userspace"

	einfo "Building kernel modules"
	unset ARCH
	emake KSRC="${KERNEL_DIR}" mods || die "failed to build module"
}

src_install() {
	einfo "Installing userspace"
	dosbin usr/ietd usr/ietadm || die "dosbin failed"
	insinto /etc
	doins etc/ietd.conf etc/initiators.{allow,deny} || die "doins failed"
	# Upstream's provided Gentoo init script is out of date compared to
	# their Debian init script. And isn't that nice.
	#newinitd etc/initd/initd.gentoo ietd || die
	newinitd ${FILESDIR}/ietd-init.d ietd || die "newinitd failed"
	newconfd ${FILESDIR}/ietd-conf.d ietd || die "newconfd failed"

	doman doc/manpages/*.[1-9] || die "manpages failed"
	dodoc ChangeLog README || die "docs failed"

	einfo "Installing kernel module"
	unset ARCH
	linux-mod_src_install || die "modules failed"
}
