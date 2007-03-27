# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/truecrypt/truecrypt-4.2a-r3.ebuild,v 1.2 2007/03/27 12:21:48 alonbl Exp $

inherit linux-mod toolchain-funcs

DESCRIPTION="Free open-source disk encryption software"
HOMEPAGE="http://www.truecrypt.org/"
SRC_URI="http://www.truecrypt.org/downloads/truecrypt-${PV}-source-code.tar.gz"

LICENSE="truecrypt-collective-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/linux-sources
	sys-fs/device-mapper"

RDEPEND="sys-fs/device-mapper"

pkg_setup() {
	linux-info_pkg_setup
	dmcrypt_check
	kernel_is lt 2 6 5 && die 'requires at least 2.6.5 kernel version'

	BUILD_PARAMS="KERNEL_SRC=${KERNEL_DIR} NO_WARNINGS=1"
	BUILD_TARGETS="truecrypt"
	MODULE_NAMES="truecrypt(block:${S}/Linux/Kernel)"

}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}_kernel-2.6.18-rc1_fix.patch"
	epatch "${FILESDIR}/${P}-2.6.19.patch"
	epatch "${FILESDIR}/${P}-2.6.20.patch"
	epatch "${FILESDIR}/${P}-makefile.patch"
	linux-mod_pkg_setup
}

src_compile() {
	linux-mod_src_compile || die "Truecrypt module compilation failed."
	cd "${S}/Linux/Cli"
	einfo "Building truecrypt utility"
	tc-export CC
	# remove kernel linked crypt stuff
	emake clean || die "make clean failed"
	emake truecrypt NO_STRIP=1 || die "Compile and/or linking of TrueCrypt Linux CLI application failed."
}

src_test() {
	"${S}/Linux/Cli/truecrypt" --test
}

pkg_preinst() {
	# unload truecrypt modules if already loaded
	/sbin/rmmod truecrypt >&- 2>&-
	if grep -q "^truecrypt" /proc/modules
	then
		die "Please dismount all mounted TrueCrypt volumes"
	fi
}

src_install() {
	# installing files
	dobin Linux/Cli/truecrypt
	doman Linux/Cli/Man/truecrypt.1
	dodoc Readme.txt 'Release/Setup Files/TrueCrypt User Guide.pdf'
	insinto "/$(get_libdir)/rcscripts/addons"
	newins "${FILESDIR}/${PN}-stop.sh" "${PN}-stop.sh"

	# installing kernel module
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog " For TrueCrypt 4.2 to work you have to load a "
	elog " kernel module. This can be done in three ways: "
	elog
	elog " 1. Loading the module automatically by the running kernel. "
	elog "    For this 'Automatic kernel module loading' needs to be "
	elog "    enabled (CONFIG_KMOD=y). "
	elog " 2. Loading the module manually before mounting the volume. "
	elog "    Try 'modprobe truecrypt' as root to load the module. "
	elog " 3. Load the module during boot by listing it in "
	elog "    '/etc/modules.autoload.d/kernel-2.6' "
}

dmcrypt_check() {
	ebegin "Checking for Device mapper support (BLK_DEV_DM)"
	linux_chkconfig_present BLK_DEV_DM
	eend $?

	if [[ $? -ne 0 ]] ; then
		ewarn "TrueCrypt requires Device mapper support!"
		ewarn "Please enable Device mapper support in your kernel config, found at:"
		ewarn "(for 2.6 kernels)"
		ewarn
		ewarn "  Device Drivers"
		ewarn "    Multi-Device Support"
		ewarn "      <*> Device mapper support"
		ewarn
		ewarn "and recompile your kernel if you want this package to work."
		epause 10
	fi
}

