# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-stunnel/selinux-stunnel-20041112.ebuild,v 1.1 2004/11/14 20:53:40 kaiowas Exp $

inherit selinux-policy

TEFILES="stunnel.te"
FCFILES="stunnel.fc"
IUSE=""

DESCRIPTION="SELinux policy for stunnel"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

