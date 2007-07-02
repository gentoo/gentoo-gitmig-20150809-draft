# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup-luks/cryptsetup-luks-1.0.3-r3.ebuild,v 1.2 2007/07/02 15:33:24 peper Exp $

inherit autotools linux-info eutils flag-o-matic multilib

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="http://luks.endorphin.org/"
SRC_URI="http://luks.endorphin.org/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="build dynamic nls selinux"

DEPEND=">=sys-fs/device-mapper-1.00.07-r1
	>=dev-libs/libgcrypt-1.1.42
	>=dev-libs/libgpg-error-1.0-r1
	selinux? ( sys-libs/libselinux )
	!sys-fs/cryptsetup"

dm-crypt_check() {
	local CONFIG_CHECK="~DM_CRYPT"
	local WARNING_DM_CRYPT="CONFIG_DM_CRYPT:\tis not set (required for cryptsetup-luks)"
	check_extra_config
	echo
}

crypto_check() {
	local CONFIG_CHECK="~CRYPTO"
	local WARNING_CRYPTO="CONFIG_CRYPTO:\tis not set (required for cryptsetup-luks)"
	check_extra_config
	echo
}

pkg_setup() {
	# Bug 148390
	if ! use build ; then
		linux-info_pkg_setup
		dm-crypt_check
		crypto_check
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-selinux.patch
	eautoconf || die
	touch aclocal.m4 Makefile.in configure
}

src_compile() {
	if use dynamic ; then
		ewarn "If you need cryptsetup for an initrd or initramfs then you"
		ewarn "should NOT use the dynamic USE flag"
		epause 5
	fi

	econf \
		--sbindir=/bin \
		$(use_enable !dynamic static) \
		--libdir=/usr/$(get_libdir) \
		$(use_enable nls) \
		$(use_enable selinux) \
		|| die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	rmdir "${D}/usr/$(get_libdir)/cryptsetup"
	insinto /lib/rcscripts/addons
	newins "${FILESDIR}"/"${PV}"-dm-crypt-start.sh dm-crypt-start.sh
	newins "${FILESDIR}"/"${PV}"-dm-crypt-stop.sh dm-crypt-stop.sh
	newconfd "${FILESDIR}"/"${PV}"-cryptfs.confd cryptfs
}

pkg_postinst() {
	ewarn "This ebuild introduces a new set of scripts and configuration"
	ewarn "then the previous system. If you are currently using /etc/conf.d/crypfs"
	ewarn "then you *MUST* read the new /etc/conf.d/cryptfs for instructions"
	ewarn "on how to convert your previous cryptfs to the new syntax or your"
	ewarn "encrypted partitions will *NOT* work."
	einfo
	einfo "Please see the example for configuring a LUKS mountpoint"
	einfo "in /etc/conf.d/cryptfs"
	einfo
}
