# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-clamav/selinux-clamav-20050626.ebuild,v 1.1 2005/06/26 12:12:02 kaiowas Exp $

inherit selinux-policy

TEFILES="clamav.te"
FCFILES="clamav.fc"
MACROS="clamav_macros.te"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for Clam AntiVirus"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

