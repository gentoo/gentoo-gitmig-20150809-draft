# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin/kdeadmin-3.1.1-r2.ebuild,v 1.1 2003/04/24 21:35:52 danarmak Exp $
inherit kde-dist 

IUSE="pam foreign-package foreign-sysvinit"
DESCRIPTION="KDE administration tools (user manager, etc.)"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

newdepend ">=app-arch/rpm-4.0.4-r1
	dev-libs/popt
	pam? ( >=sys-libs/pam-0.72 )
	foreign-package? ( app-arch/rpm )"

use pam		&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"

if [ -n "`use foreign-package`" ]; then
    myconf="$myconf --with-rpmlib"
else
    myconf="$myconf --without-rpm"
    KDE_REMOVE_DIR="$KDE_REMOVE_DIR kpackage"
fi

if [ -z "`use foreign-sysvinit`" ]; then
    KDE_REMOVE_DIR="$KDE_REMOVE_DIR ksysv"
fi


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
