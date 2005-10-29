# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mdadm/selinux-mdadm-20051029.ebuild,v 1.1 2005/10/29 02:48:55 spb Exp $

inherit selinux-policy

TEFILES="mdadm.te"
FCFILES="mdadm.fc"
IUSE=""

DESCRIPTION="SELinux policy for mdadm"

#KEYWORDS="amd64 mips ppc sparc x86"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
