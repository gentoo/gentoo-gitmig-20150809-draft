# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20040925.ebuild,v 1.3 2005/01/20 10:04:01 kaiowas Exp $

inherit selinux-policy

TEFILES="named.te"
FCFILES="named.fc"
IUSE=""

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="x86 ppc sparc amd64"

RDEPEND=">=sec-policy/selinux-base-policy-20041023"

