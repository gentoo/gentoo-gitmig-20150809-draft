# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ftpd/selinux-ftpd-20041120.ebuild,v 1.1 2004/11/22 20:40:41 kaiowas Exp $

inherit selinux-policy

TEFILES="ftpd.te"
FCFILES="ftpd.fc"
IUSE=""

DESCRIPTION="SELinux policy for ftp daemons"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

