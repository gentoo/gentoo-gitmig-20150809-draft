# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-snort/selinux-snort-20050219.ebuild,v 1.1 2005/02/25 08:27:09 kaiowas Exp $

inherit selinux-policy

TEFILES="snort.te"
FCFILES="snort.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050224"

DESCRIPTION="SELinux policy for snort"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

