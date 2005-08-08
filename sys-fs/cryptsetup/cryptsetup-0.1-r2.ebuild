# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup/cryptsetup-0.1-r2.ebuild,v 1.5 2005/08/08 11:27:04 ka0ttic Exp $

inherit linux-info multilib eutils

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="http://www.saout.de/misc/dm-crypt/"
SRC_URI="http://www.saout.de/misc/dm-crypt/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-fs/device-mapper-1.00.07-r1
	>=dev-libs/libgcrypt-1.1.42
	!sys-fs/cryptsetup-luks"

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
	econf --bindir=/bin --disable-nls || die

	sed -i \
		-e "s|-lgcrypt|/usr/$(get_libdir)/libgcrypt.a|" \
		-e "s|-lgpg-error|/usr/$(get_libdir)/libgpg-error.a|" \
		Makefile src/Makefile
	sed -i -e "s|-lpopt|/usr/$(get_libdir)/libpopt.a|" src/Makefile

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	newconfd ${FILESDIR}/cryptfs.confd cryptfs
	insinto /lib/rcscripts/addons
	doins "${FILESDIR}"/dm-crypt-{start,stop}.sh
}
