# Copyright 2005-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/static-dev/static-dev-0.1.ebuild,v 1.3 2006/05/01 14:11:12 josejx Exp $

DESCRIPTION="A skeleton, statically managed /dev"
HOMEPAGE="http://bugs.gentoo.org/show_bug.cgi?id=107875"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~ia64 ~m68k ~mips ppc ~s390 ~sparc x86"
IUSE=""
RDEPEND="virtual/baselayout"
PROVIDE="virtual/dev-manager"

pkg_setup() {
	if [[ -d /dev/.udev/ || ! -c /dev/.devfs ]]; then
		echo ""
		eerror "We have detected that you currently use udev or devfs"
		eerror "and this ebuild cannot install to the same mount-point."
		eerror "Please reinstall the ebuild (as root) like follows:"
		eerror ""
		eerror "mkdir /tmp/newroot"
		eerror "mount -o bind / /tmp/newroot"
		eerror "ROOT=/tmp/newroot/ emerge sys-fs/static-dev"
		eerror "umount /tmp/newroot"
		die "Cannot install on udev/devfs tmpfs."
	fi
}

pkg_postinst() {
	local x="generic"
	local makedev

	cd "${ROOT}/dev/" || die "Unable to descend into ${ROOT}/dev/"

	for arch in alpha arm hppa ia64 m68k mips s390 sparc; do
		use ${arch} && x="${x} generic-${arch}"
	done

	[[ "${CHOST:0:7}" == "mipsel-" ]] && x="${x} generic-mipsel"

	( use x86 || use amd64 ) && x="${x} generic-i386"
	( use ppc || use ppc64 ) && x="${x} generic-powerpc"

	[[ -e ${ROOT}/dev/MAKEDEV ]] && makedev="${ROOT}/dev/MAKEDEV" || makedev="/dev/MAKEDEV"

	einfo "Making device nodes for ${x}"
	sh ${makedev} ${x} || die "No ${makedev}?"
}

src_compile() {
	:
}

src_install() {
	:
}
