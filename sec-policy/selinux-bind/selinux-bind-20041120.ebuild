# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20041120.ebuild,v 1.1 2004/11/22 20:24:14 kaiowas Exp $

inherit selinux-policy

TEFILES="named.te"
FCFILES="named.fc"
IUSE=""

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND=">=sec-policy/selinux-base-policy-20041023"

