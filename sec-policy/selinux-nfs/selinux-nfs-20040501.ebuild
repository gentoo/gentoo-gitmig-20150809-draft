# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nfs/selinux-nfs-20040501.ebuild,v 1.1 2004/05/01 19:59:21 pebenito Exp $

TEFILES="rpcd.te"
FCFILES="rpcd.fc"
IUSE=""

inherit selinux-policy

RDEPEND="sec-policy/selinux-portmap"

DESCRIPTION="SELinux policy for NFS"

KEYWORDS="x86 ppc sparc"

