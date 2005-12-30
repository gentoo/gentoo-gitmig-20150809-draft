# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ethereal/selinux-ethereal-20050918.ebuild,v 1.2 2005/12/30 07:13:11 kaiowas Exp $

inherit selinux-policy

TEFILES="ethereal.te"
FCFILES="ethereal.fc"
MACROS="ethereal_macros.te"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for ethereal"

KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"

