# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-samba/selinux-samba-20050526.ebuild,v 1.1 2005/05/26 12:06:22 kaiowas Exp $

inherit selinux-policy

TEFILES="samba.te"
FCFILES="samba.fc"
IUSE=""

DESCRIPTION="SELinux policy for samba"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

