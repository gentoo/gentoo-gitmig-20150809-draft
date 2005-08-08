# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup-luks/cryptsetup-luks-1.0.1.ebuild,v 1.2 2005/08/08 11:49:21 ka0ttic Exp $

inherit linux-info eutils multilib flag-o-matic

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="http://clemens.endorphin.org/LUKS/"
SRC_URI="http://luks.endorphin.org/source/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips ~ppc ~x86"

DEPEND=">=sys-fs/device-mapper-1.00.07-r1
		>=dev-libs/libgcrypt-1.1.42
		>=dev-libs/libgpg-error-1.0-r1
		!sys-fs/cryptsetup"

IUSE="static"

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
	linux-info_pkg_setup
	dm-crypt_check;
}

src_compile() {
	cd ${S}

	if use static ; then
		append-ldflags -static
		econf --sbindir=/bin --enable-static --disable-nls || die
	else
		ewarn "If you need cryptsetup for an initrd or initramfs then you"
		ewarn "should emerge cryptsetup-luks with USE="static""
		epause 5
		econf --sbindir=/bin --disable-static --disable-nls || die

		sed -i \
			-e "s|-lgcrypt|/usr/$(get_libdir)/libgcrypt.a|" \
			-e "s|-lgpg-error|/usr/$(get_libdir)/libgpg-error.a|" \
			Makefile src/Makefile
		sed -i -e "s|-lpopt|/usr/$(get_libdir)/libpopt.a|" src/Makefile
	fi

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	insinto /lib/rcscripts/addons
	newconfd ${FILESDIR}/cryptfs.confd cryptfs
	doins "${FILESDIR}"/dm-crypt-{start,stop}.sh
}

pkg_postinst() {
	einfo "Please see the example for configuring a LUKS mountpoint"
	einfo "in /etc/conf.d/cryptfs"
}
