# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-logrotate/selinux-logrotate-20041120.ebuild,v 1.1 2004/11/22 20:47:00 kaiowas Exp $

inherit selinux-policy

TEFILES="logrotate.te"
FCFILES="logrotate.fc"
IUSE=""

DESCRIPTION="SELinux policy for logrotate"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

