# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ipsec-tools/selinux-ipsec-tools-20040703.ebuild,v 1.3 2005/01/20 09:26:37 kaiowas Exp $

TEFILES="ipsec.te"
FCFILES="ipsec.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for IPSEC tools"

KEYWORDS="x86 ppc sparc amd64"

