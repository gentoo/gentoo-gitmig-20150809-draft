# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-tftpd/selinux-tftpd-20050701.ebuild,v 1.1 2005/08/23 06:25:28 kaiowas Exp $

inherit selinux-policy

TEFILES="tftpd.te"
FCFILES="tftpd.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for tftp daemons"

KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips"

