# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lvm/selinux-lvm-20061008.ebuild,v 1.3 2009/07/22 13:12:39 pebenito Exp $

IUSE=""

DESCRIPTION="SELinux policy for Logical Volume Management"
HOMEPAGE="http://hardened.gentoo.org"
LICENSE="GPL-2"
SLOT="0"

# moved to base policy
DEPEND=">=sec-policy/selinux-base-policy-20060101"
RDEPEND="${DEPEND}"

KEYWORDS="amd64 x86"
