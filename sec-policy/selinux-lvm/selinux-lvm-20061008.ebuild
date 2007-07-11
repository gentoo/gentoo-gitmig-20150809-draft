# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lvm/selinux-lvm-20061008.ebuild,v 1.2 2007/07/11 02:56:48 mr_bones_ Exp $

IUSE=""

DESCRIPTION="SELinux policy for Logical Volume Management"
HOMEPAGE="http://hardened.gentoo.org"
LICENSE="GPL-2"
SLOT="0"

# moved to base policy
DEPEND=">=sec-policy/selinux-base-policy-20060101"
RDEPEND="${DEPEND}"

KEYWORDS="alpha amd64 mips ppc sparc x86"
