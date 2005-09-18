# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lvm/selinux-lvm-20050813.ebuild,v 1.2 2005/09/18 10:38:54 kaiowas Exp $

inherit selinux-policy

TEFILES="lvm.te"
FCFILES="lvm.fc"
IUSE=""

DESCRIPTION="SELinux policy for Logical Volume Management"

KEYWORDS="amd64 mips ppc sparc x86"

