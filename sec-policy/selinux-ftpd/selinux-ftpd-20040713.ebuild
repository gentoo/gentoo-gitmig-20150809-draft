# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ftpd/selinux-ftpd-20040713.ebuild,v 1.3 2005/01/20 09:21:35 kaiowas Exp $

TEFILES="ftpd.te"
FCFILES="ftpd.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for ftp daemons"

KEYWORDS="x86 ppc sparc amd64"

