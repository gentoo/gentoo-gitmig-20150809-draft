# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/usb-pwc-re/usb-pwc-re-10.0.6a.ebuild,v 1.7 2005/04/06 18:53:55 corsair Exp $


inherit linux-info toolchain-funcs eutils

DESCRIPTION="A fork of the discontinuity pwc driver made by Nemosoft Unv. Most of the pwcx functionality has been reverse engineered."
HOMEPAGE="http://www.saillard.org/pwc/"
SRC_URI="http://www.saillard.org/pwc/files/pwc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc64 ~amd64"
IUSE=""
DEPEND=""
S=${WORKDIR}/pwc-${PV}

src_compile() {
	export ARCH="$(tc-arch-kernel)"
	emake || die "make failed"
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
