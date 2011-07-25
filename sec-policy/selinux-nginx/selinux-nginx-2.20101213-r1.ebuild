# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nginx/selinux-nginx-2.20101213-r1.ebuild,v 1.1 2011/07/25 23:06:58 blueness Exp $

IUSE=""

MODS="nginx"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for nginx web server application"

KEYWORDS="~amd64 ~x86"
DEPEND="sec-policy/selinux-base-policy
		sec-policy/selinux-apache"
RDEPEND="${DEPEND}"

POLICY_PATCH="${FILESDIR}/fix-services-nginx-r1.patch"
