# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lvm/selinux-lvm-20050408.ebuild,v 1.1 2005/04/23 18:24:29 kaiowas Exp $

inherit selinux-policy

TEFILES="lvm.te"
FCFILES="lvm.fc"
IUSE=""

DESCRIPTION="SELinux policy for Logical Volume Management"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

