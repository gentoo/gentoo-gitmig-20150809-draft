# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bind/selinux-bind-20031222.ebuild,v 1.1 2003/12/23 01:12:46 pebenito Exp $

TEFILES="named.te"
FCFILES="named.fc"

inherit selinux-policy

DESCRIPTION="SELinux policy for BIND"

KEYWORDS="~x86 ~ppc ~sparc"

