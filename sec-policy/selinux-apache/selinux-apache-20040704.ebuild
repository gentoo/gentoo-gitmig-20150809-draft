# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-apache/selinux-apache-20040704.ebuild,v 1.1 2004/07/05 01:27:01 pebenito Exp $

TEFILES="apache.te"
FCFILES="apache.fc"
MACROS="apache_macros.te"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for Apache HTTPD"

KEYWORDS="x86 ppc sparc"

