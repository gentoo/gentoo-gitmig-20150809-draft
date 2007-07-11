# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-apache/selinux-apache-20050211.ebuild,v 1.3 2007/07/11 02:56:48 mr_bones_ Exp $

inherit selinux-policy

TEFILES="apache.te"
FCFILES="apache.fc"
MACROS="apache_macros.te"
IUSE=""

DESCRIPTION="SELinux policy for Apache HTTPD"

KEYWORDS="x86 ppc sparc amd64"
