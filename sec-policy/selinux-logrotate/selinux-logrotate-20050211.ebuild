# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-logrotate/selinux-logrotate-20050211.ebuild,v 1.2 2005/03/23 07:43:26 kaiowas Exp $

inherit selinux-policy

TEFILES="logrotate.te"
FCFILES="logrotate.fc"
IUSE=""

DESCRIPTION="SELinux policy for logrotate"

KEYWORDS="x86 ppc sparc amd64"

