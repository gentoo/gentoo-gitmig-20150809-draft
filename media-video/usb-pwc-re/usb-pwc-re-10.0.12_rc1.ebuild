# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/usb-pwc-re/usb-pwc-re-10.0.12_rc1.ebuild,v 1.1 2006/04/24 06:25:24 phosphan Exp $


inherit linux-info toolchain-funcs eutils

DESCRIPTION="Free Philips USB Webcam driver for Linux that supports VGA resolution, newer kernels and replaces the old pwcx module."
HOMEPAGE="http://www.saillard.org/pwc/"
MY_PV="${PV/_/-}"
SRC_URI="http://www.saillard.org/pwc/files/pwc-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
DEPEND="sys-kernel/linux-headers"
RDEPEND=""

S=${WORKDIR}/pwc-${MY_PV}

src_compile() {
	export ARCH="$(tc-arch-kernel)"
	emake KSRC="${KERNEL_DIR}" || die "make failed"
	test -f pwc.ko || die "You can't have both at once - a builtin driver and a module."
}

src_install() {

	if kernel_is 2 6; then
		einfo "Kernel ${KV_FULL} detected!"
		insinto "/lib/modules/${KV_FULL}/kernel/drivers/usb/media/pwc"
		doins pwc.ko
		echo "post-install pwc /sbin/modprobe --force pwcx >& /dev/null 2>&1 || :" > usb-pwcx
	else
		eerror "No supported kernel version (2.6) detected."
	fi

	insinto /etc/modules.d

}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
		depmod -a
	fi
	einfo "If you have problems loading the module, please check the \"dmesg\" output."
}
