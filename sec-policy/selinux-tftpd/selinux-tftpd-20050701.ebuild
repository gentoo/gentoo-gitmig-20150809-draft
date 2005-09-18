# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-tftpd/selinux-tftpd-20050701.ebuild,v 1.2 2005/09/18 10:31:38 kaiowas Exp $

inherit selinux-policy

TEFILES="tftpd.te"
FCFILES="tftpd.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for tftp daemons"

KEYWORDS="amd64 mips ppc sparc x86"

