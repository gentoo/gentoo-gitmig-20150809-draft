# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-logrotate/selinux-logrotate-20031129.ebuild,v 1.6 2004/09/20 01:55:47 pebenito Exp $

TEFILES="logrotate.te"
FCFILES="logrotate.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for logrotate"

KEYWORDS="x86 ppc sparc amd64"

