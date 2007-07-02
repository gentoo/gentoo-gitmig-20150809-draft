# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup-luks/cryptsetup-luks-1.0.3-r2.ebuild,v 1.17 2007/07/02 15:33:24 peper Exp $

inherit autotools linux-info eutils flag-o-matic multilib

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="http://luks.endorphin.org/"
SRC_URI="http://luks.endorphin.org/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="dynamic nls selinux"

DEPEND=">=sys-fs/device-mapper-1.00.07-r1
	>=dev-libs/libgcrypt-1.1.42
	>=dev-libs/libgpg-error-1.0-r1
	selinux? ( sys-libs/libselinux )
	!sys-fs/cryptsetup"

dm-crypt_check() {
	ebegin "Checking for dm-crypt support"
	linux_chkconfig_present DM_CRYPT
	eend $?

	if [[ $? -ne 0 ]] ; then
		ewarn "cryptsetup requires dm-crypt support!"
		ewarn "Please enable dm-crypt support in your kernel config, found at:"
		ewarn "(for 2.6 kernels)"
		ewarn
		ewarn "  Device Drivers"
		ewarn "    Multi-Device Support"
		ewarn "      Device mapper support"
		ewarn "        [*] Crypt Target Support"
		ewarn
		ewarn "and recompile your kernel if you want this package to work with this kernel"
		epause 5
	fi
}

pkg_setup() {
	dm-crypt_check
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
	newconfd "${FILESDIR}"/cryptfs.confd cryptfs
	doins "${FILESDIR}"/dm-crypt-{start,stop}.sh
}

pkg_postinst() {
	einfo "Please see the example for configuring a LUKS mountpoint"
	einfo "in /etc/conf.d/cryptfs"
}
