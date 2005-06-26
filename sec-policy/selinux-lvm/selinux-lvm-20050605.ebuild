# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lvm/selinux-lvm-20050605.ebuild,v 1.1 2005/06/26 17:10:24 kaiowas Exp $

inherit selinux-policy

TEFILES="lvm.te"
FCFILES="lvm.fc"
IUSE=""

DESCRIPTION="SELinux policy for Logical Volume Management"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

