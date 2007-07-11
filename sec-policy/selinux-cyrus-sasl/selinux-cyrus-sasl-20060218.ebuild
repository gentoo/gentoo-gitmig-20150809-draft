# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-cyrus-sasl/selinux-cyrus-sasl-20060218.ebuild,v 1.2 2007/07/11 02:56:48 mr_bones_ Exp $

inherit selinux-policy

TEFILES="saslauthd.te"
FCFILES="saslauthd.fc"
IUSE=""

DESCRIPTION="SELinux policy for cyrus-sasl"

KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
