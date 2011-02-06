# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/static-dev/static-dev-0.1.ebuild,v 1.12 2011/02/06 11:05:58 leio Exp $

inherit toolchain-funcs

DESCRIPTION="A skeleton, statically managed /dev"
HOMEPAGE="http://bugs.gentoo.org/107875"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="|| ( sys-apps/makedev =sys-apps/baselayout-1* )"

PROVIDE="virtual/dev-manager"

pkg_preinst() {
	if [[ -d ${ROOT}/dev/.udev || -c ${ROOT}/dev/.devfs ]] ; then
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

src_install() {
	dodir /dev
	cd "${D}"/dev/ || die "Unable to descend into /dev"

	# keep in sync with sys-apps/baselayout
	local suffix=""
	case $(tc-arch) in
		arm*)    suffix=-arm ;;
		alpha)   suffix=-alpha ;;
		amd64)   suffix=-i386 ;;
		hppa)    suffix=-hppa ;;
		ia64)    suffix=-ia64 ;;
		m68k)    suffix=-m68k ;;
		mips*)   suffix=-mips ;;
		ppc*)    suffix=-powerpc ;;
		s390*)   suffix=-s390 ;;
		sh*)     suffix=-sh ;;
		sparc*)  suffix=-sparc ;;
		x86)     suffix=-i386 ;;
	esac

	einfo "Using generic${suffix} to make $(tc-arch) device nodes..."

	MAKEDEV -d "${D}"/dev generic${suffix} || die
	MAKEDEV -d "${D}"/dev sg scd rtc hde hdf hdg hdh input audio video || die
}
