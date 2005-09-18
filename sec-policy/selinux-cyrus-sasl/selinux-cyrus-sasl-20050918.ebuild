# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-cyrus-sasl/selinux-cyrus-sasl-20050918.ebuild,v 1.1 2005/09/18 09:56:24 kaiowas Exp $

inherit selinux-policy

TEFILES="saslauthd.te"
FCFILES="saslauthd.fc"
IUSE=""

DESCRIPTION="SELinux policy for cyrus-sasl"

KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"

