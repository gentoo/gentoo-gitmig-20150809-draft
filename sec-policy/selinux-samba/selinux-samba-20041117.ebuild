# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-samba/selinux-samba-20041117.ebuild,v 1.1 2004/11/17 15:29:09 kaiowas Exp $

inherit selinux-policy

TEFILES="samba.te"
FCFILES="samba.fc"
IUSE=""

DESCRIPTION="SELinux policy for samba"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

