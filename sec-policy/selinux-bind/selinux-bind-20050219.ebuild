# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20050219.ebuild,v 1.3 2005/03/23 07:32:47 kaiowas Exp $

inherit selinux-policy

TEFILES="named.te"
FCFILES="named.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050224"

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="x86 ppc sparc amd64"

