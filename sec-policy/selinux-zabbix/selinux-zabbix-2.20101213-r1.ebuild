# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-zabbix/selinux-zabbix-2.20101213-r1.ebuild,v 1.1 2011/06/30 10:04:18 blueness Exp $
EAPI="4"

IUSE=""

MODS="zabbix"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for general applications"

KEYWORDS="~amd64 ~x86"

POLICY_PATCH="${FILESDIR}/fix-services-zabbix-r1.patch"
