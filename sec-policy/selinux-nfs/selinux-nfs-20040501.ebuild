# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nfs/selinux-nfs-20040501.ebuild,v 1.5 2007/07/11 02:56:48 mr_bones_ Exp $

TEFILES="rpcd.te"
FCFILES="rpcd.fc"
IUSE=""

inherit selinux-policy

RDEPEND="sec-policy/selinux-portmap"

DESCRIPTION="SELinux policy for NFS"

KEYWORDS="amd64 ~mips ppc sparc x86"
