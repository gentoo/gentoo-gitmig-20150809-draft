# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nfs/selinux-nfs-20040501.ebuild,v 1.3 2004/09/20 01:55:47 pebenito Exp $

TEFILES="rpcd.te"
FCFILES="rpcd.fc"
IUSE=""

inherit selinux-policy

RDEPEND="sec-policy/selinux-portmap"

DESCRIPTION="SELinux policy for NFS"

KEYWORDS="x86 ppc sparc amd64"

