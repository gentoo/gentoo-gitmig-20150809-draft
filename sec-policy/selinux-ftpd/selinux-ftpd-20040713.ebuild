# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ftpd/selinux-ftpd-20040713.ebuild,v 1.1 2004/07/13 14:00:49 method Exp $

TEFILES="ftpd.te"
FCFILES="ftpd.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for ftp daemons"

KEYWORDS="x86 ppc sparc"

