# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.2.0_beta2.ebuild,v 1.5 2003/12/28 03:51:52 caleb Exp $
inherit kde-dist

IUSE="pam"
DESCRIPTION="KDE administration tools (user manager, etc.)"
KEYWORDS="~x86"

DEPEND="~kde-base/kdebase-${PV}
	pam? ( >=sys-libs/pam-0.72 )"
RDEPEND="$DEPEND"

myconf="$myconf --without-rpm"
DO_NOT_COMPILE="$DO_NOT_COMPILE kpackage ksysv"

# we only want to compile the lilo config module on x86, but there we want to make sure it's
# always compiled to ensure consistent behaviour of the package across both lilo and grub systems,
# because configure when left to its own devices will build lilo-config or not basd on whether
# lilo is present in the path.
# so, we make configure build it by removing the configure.in.in file that checks for
# lilo's presense
src_unpack() {
	kde_src_unpack
	use x86 && echo > ${S}/lilo-config/configure.in.in
}

# TODO: add nis support
