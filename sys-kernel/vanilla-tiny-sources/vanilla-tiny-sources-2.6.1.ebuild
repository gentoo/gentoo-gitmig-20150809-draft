# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-tiny-sources/vanilla-tiny-sources-2.6.1.ebuild,v 1.1 2004/02/12 02:48:15 zul Exp $

TINY_V="2.6.1"
TINY_SRC="http://www.selenic.com/tiny/${TINY_V}-tiny1.patch.bz2 http://www.selenic.com/tiny/${TINY_V}-tiny1.txt"

UNIPATCH_LIST="${DISTDIR}/${TINY_V}-tiny1.patch.bz2"
UNIPATCH_DOCS="${DISTDIR}/${TINY_V}-tiny1.txt"
K_NOSETEXTRAVERSION="${PN/tiny/}"
UNIPATCH_STRICTORDER="yes"

ETYPE="sources"
inherit kernel-2
detect_version

RESTRICT="nomirror"

DESCRIPTION="Kernel sources aimed at embedded systsms and users of small or legacy machines."
SRC_URI="${KERNEL_URI} ${TINY_SRC}"

KEYWORDS="~x86"

K_EXTRAEINFO="If there are any issues with this kernel, search http://bugs.gentoo.org for an existing bug. Only create a new bug if you have not found one that
mathces your issue. It is best to do an advanced search as the initial search
has a very low yield. Please assign your bugs to zul@gentoo.org.
Please read the ChangeLog and associated docs for more information."

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "To enable tiny-sources features"
	ewarn "General setup -> Configuure standard kernel features (for small systems"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following options"
	ewarn "    Device Drivers -> Character devices  -> Unix98 PTY Support"
	ewarn "    File systems   -> Pseudo filesystems -> /dev/pts filesystem."
	echo
}
