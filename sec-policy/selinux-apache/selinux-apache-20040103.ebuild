# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-apache/selinux-apache-20040103.ebuild,v 1.2 2004/03/26 21:13:52 aliz Exp $

TEFILES="apache.te"
FCFILES="apache.fc"
MACROS="apache_macros.te"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for Apache HTTPD"

KEYWORDS="x86 ppc sparc"

