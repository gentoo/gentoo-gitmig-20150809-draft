# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-sources/linux-sources-2.4.19-r1.ebuild,v 1.5 2002/07/17 00:48:28 seemant Exp $

SLOT="0"
LICENSE="GPL"
DESCRIPTION="Obsolete kernel package.  Please choose another"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
SRC_URI=""
KEYWORDS="x86 ppc"

pkg_setup() {
	clear
	einfo "On 22 April, 2002, we started using a new and improved organizational"
	einfo "structure for our kernel source ebuilds.  The new system is much easier"
	einfo "to understand and use.  This ebuild is a \"stub\" ebuild designed with"
	einfo "the sole purpose of explaining how the new system works."
	echo
	echo "If you're seeing this message, you probably typed \"emerge" 
	echo "sys-kernel/linux-sources.\"  Our new kernel source organization doesn't have"
	echo "a linux-sources ebuild anymore.  Instead, we now offer the following selection"
	echo "of Linux kernel source ebuilds.  You should choose the best one for your needs:"
	echo
	einfo "sys-kernel/gentoo-sources"
	echo "The gentoo-sources ebuild is our replacement for our previous linux-sources"
	echo "ebuild.  We try to ensure that this kernel is very fast and stable and we"
	echo "recommend this kernel for most people.  However, XFS support is no longer"
	echo "included in this kernel.  If you use XFS, use sys-kernel/xfs-sources."
	echo
	einfo "sys-kernel/vanilla-sources"
	echo "The vanilla-sources ebuild installs a \"mainline\" kernel source tree, giving"
	echo "you the exact same thing as if you downloaded a stock kernel from kernel.org."
	echo 
	echo '(press Enter to continue)'
	read
	echo "(continued...)"
	einfo "sys-kernel/usermode-sources"
	echo "This usermode-sources ebuild installs mainline sources that have been patched"
	echo "to support user-mode Linux (a special technology that allows you to run"
	echo "\"Linux inside Linux.\")"
	echo
	einfo "sys-kernel/xfs-sources"
	echo "The xfs-sources ebuild installs sources that support XFS; specifically, this"
	echo "ebuild contains a CVS snapshot of SGI's own XFS source tree.  In the future, we"
	echo "may add other minor (and stable) performance-enhancing patches as well.  We've"
	echo "found that using a SGI XFS CVS shapshot is the best way to go if you're going"
	echo "to use the XFS filesystem.  If any of your Gentoo Linux filesystems are XFS,"
	echo "then, you'll need to use this kernel."
	echo
	einfo "sys-kernel/openmosix-sources"
	echo "The openmosix-sources ebuild installs a kernel source tree that has been"
	echo "specially patched with support for the GPL openMosix clustering and load-"
	echo "balancing technology.  For more info, see http://www.openmosix.com."
	echo 
	echo "We hope you find the new layout easier to use.  Again, if you typed"
	echo "\"emerge linux-sources\" to install a kernel source tree, simply install"
	echo "one of the above kernels instead: ie, \"emerge gentoo-sources\""
	echo
	exit 1
}
