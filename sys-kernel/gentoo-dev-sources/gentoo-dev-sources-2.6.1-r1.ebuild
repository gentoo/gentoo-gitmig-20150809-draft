# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.1-r1.ebuild,v 1.2 2004/01/12 22:24:44 johnm Exp $

# As this is the example source to use kernel-2.eclass then a very brief explanation is to go here
#
# any logic required for K_NOSETEXTRAVERSION, K_NOUSENAME UNIPATCH_LIST, or UNIPATCH_DOCS should
# go BEFORE the inherit.
# if you choose to not use detect_version then you should set EXTRAVERSION, KV, OKV and possibly S
# BEFORE the inherit also.
# If you wish to display additional postinst messages it is desired to pass it within K_EXTRAEINFO
# This isnt always suitable if you required it to keep original formatting.
#
# patches should be passed as a list in UNIPATCH_LIST, this can contain tarballs, individual files or
# patch numbers which you wish to be excluded from patching.
#
# any documentation which comes distributed with the patches should be added into UNIPATCH_DOCS and will
# therefore be merged into /usr/share/doc
# all patches passed are extracted or moved to ${WORKDIR}/patches

#version of gentoo patchset
GPV=1.16
GPV_SRC="http://dev.gentoo.org/~brad_mssw/kernel_patches/DO_NOT_UPLOAD_TO_MIRRORS_WITHOUT_ASKING_ME_FIRST/genpatches-2.6-${GPV}.tar.bz2"

UNIPATCH_LIST="${DISTDIR}/genpatches-2.6-${GPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/genpatches-${GPV}/README"

ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources including the gentoo patchset for the 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"

KEYWORDS="~x86 ~amd64"

pkg_postinst() {
	postinst_sources

	ewarn "IMPORTANT:"
	ewarn "ptyfs support has now been dropped from devfs and as a"
	ewarn "result you are now required to compile this support into"
	ewarn "the kernel. You can do so by enabling the following options"
	ewarn "    Device Drivers -> Character devices  -> Unix98 PTY Support"
	ewarn "    File systems   -> Pseudo filesystems -> /dev/pts filesystem."
	echo
	ewarn "To prevent the problem while uncompressing the kernel image"
	ewarn "you should also enable:"
	ewarn "    Input Devices    (Input Device Support -> Input Devices),"
	ewarn "    Virtual Terminal (Character Devices    -> Virtual Terminal),"
	ewarn "    vga_console      (Graphics Support     -> Console... -> VGA Text Console)"
	ewarn "    vt_console       (Character Devices    -> Support for Console...)"
	echo
	ewarn "If you choose to use UCL/gcloop please ensure you also"
	ewarn "emerge ucl as well as it currently depends on this library"
	echo
}
