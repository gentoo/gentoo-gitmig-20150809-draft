# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mdadm/selinux-mdadm-20061008.ebuild,v 1.1 2006/10/10 02:24:17 pebenito Exp $

IUSE=""

DESCRIPTION="SELinux policy for mdadm"
HOMEPAGE="http://hardened.gentoo.org"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=sec-policy/selinux-base-policy-20060101"
RDEPEND="${DEPEND}"

KEYWORDS="alpha amd64 mips ppc sparc x86"
