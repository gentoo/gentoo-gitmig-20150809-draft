# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20040428.ebuild,v 1.4 2005/01/20 09:05:19 kaiowas Exp $

TEFILES="named.te"
FCFILES="named.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="x86 ppc sparc amd64"

