# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/open-iscsi-0.5.485.ebuild,v 1.3 2007/06/26 02:48:53 mr_bones_ Exp $

inherit versionator linux-mod eutils flag-o-matic

DESCRIPTION="Open-iSCSI project is a high performance, transport independent, multi-platform implementation of RFC3720."
HOMEPAGE="http://www.open-iscsi.org/"
#SRC_URI="http://www.open-iscsi.org/bits/${MY_P}.tar.gz"
#SRC_URI="mirror://gentoo/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz http://dev.gentoo.org/~robbat2/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"
DEPEND="virtual/libc
		virtual/linux-sources
		=sys-libs/db-4*"
RDEPEND="${DEPEND}
		virtual/modutils
		sys-apps/util-linux"

MODULE_NAMES_ARG="kernel/drivers/scsi:${S}/kernel"
MODULE_NAMES="iscsi_tcp(${MODULE_NAMES_ARG}) scsi_transport_iscsi(${MODULE_NAMES_ARG})"
BUILD_TARGETS="all"
CONFIG_CHECK="CRYPTO_MD5 CRYPTO_CRC32C"
ERROR_CFG="open-iscsi needs both MD5 and CRC32C support in your kernel."

src_unpack() {
	unpack ${A}
	#export EPATCH_OPTS="-d${S}/kernel -p0"
	export EPATCH_OPTS="-d${S}"
	if [ $KV_PATCH -lt 11 ]; then
		die "Sorry, your kernel must be 2.6.11 or newer!"
	elif [ $KV_PATCH -eq 11 ]; then
		einfo "2.6.11 found"
		epatch ${S}/kernel/2.6.11-compat.patch
	elif [ $KV_PATCH -eq 12 ]; then
		einfo "2.6.12 found"
		epatch ${S}/kernel/2.6.12-compat.patch
	elif [ $KV_PATCH -eq 13 ]; then
		einfo "2.6.13 found"
		epatch ${S}/kernel/2.6.13-compat.patch
	elif [ $KV_PATCH -eq 14 ]; then
		einfo "2.6.14 found"
		epatch ${S}/kernel/2.6.14-and-2.6.15-compat.patch
	elif [ $KV_PATCH -eq 15 ]; then
		einfo "2.6.15 found"
		epatch ${S}/kernel/2.6.14-and-2.6.15-compat.patch
	else
		einfo "2.6.16 or newer found."
		einfo "Please file a bug if this does not compile."
	fi
}

src_compile() {
	einfo "Building kernel modules"
	export KSRC="${KERNEL_DIR}"
	use debug && append-flags -DDEBUG_TCP -DDEBUG_SCSI
	linux-mod_src_compile || die "failed to build modules"
	einfo "Building userspace"
	cd ${S}/usr && CFLAGS="" emake OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	einfo "Installing kernel modules"
	export KSRC="${KERNEL_DIR}"
	#S=${S}/kernel
	linux-mod_src_install

	einfo "Installing userspace"
	dosbin usr/iscsid usr/iscsiadm

	doman doc/*[1-8]
	dodoc README THANKS
	docinto test
	dodoc test/*

	insinto /etc
	doins etc/iscsid.conf
	doins ${FILESDIR}/initiatorname.iscsi
	newinitd ${FILESDIR}/iscsid-init.d iscsid

	# security
	keepdir /var/db/iscsi
	fperms 700 /var/db/iscsi
	fperms 600 /etc/iscsid.conf
}

pkg_postinst() {
	linux-mod_pkg_postinst
	[ -d /var/db/iscsi ] && chmod 700 /var/db/iscsi
	[ -f /etc/iscsid.conf ] && chmod 600 /etc/iscsid.conf
}
