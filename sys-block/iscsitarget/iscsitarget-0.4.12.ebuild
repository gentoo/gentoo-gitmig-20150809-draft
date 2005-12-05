# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/iscsitarget/iscsitarget-0.4.12.ebuild,v 1.1 2005/12/05 03:32:30 robbat2 Exp $

inherit linux-mod

DESCRIPTION="Open Source iSCSI target with professional features"
HOMEPAGE="http://iscsitarget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
		virtual/linux-sources"
MODULE_NAMES="iscsi_trgt(misc:${S}/kernel:${S}/kernel)"
CONFIG_CHECK="CRYPTO_CRC32C"
ERROR_CFG="iscsitarget needs support for CRC32C in your kernel."

src_compile() {
	einfo "Building userspace"
	emake progs || die "failed to build userspace"

	einfo "Building kernel modules"
	unset ARCH
	emake -C ${KERNEL_DIR} M=${S}/kernel modules || die "failed to build module"
}

src_install() {
	einfo "Installing userspace"
	dosbin usr/ietd usr/ietadm || die
	insinto /etc
	doins etc/ietd.conf etc/initiators.{allow,deny} || die
	newinitd etc/initd/initd.gentoo ietd || die
	doman doc/manpages/*.[1-9] || die
	dodoc ChangeLog README || die

	einfo "Installing kernel module"
	unset ARCH
	linux-mod_src_install || die

}
