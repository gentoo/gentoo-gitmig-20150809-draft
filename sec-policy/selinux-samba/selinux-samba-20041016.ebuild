# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-samba/selinux-samba-20041016.ebuild,v 1.1 2004/10/23 08:56:56 kaiowas Exp $

inherit selinux-policy

TEFILES="samba.te"
FCFILES="samba.fc"
IUSE=""

DESCRIPTION="SELinux policy for samba"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

