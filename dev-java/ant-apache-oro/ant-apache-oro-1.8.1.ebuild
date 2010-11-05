# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-oro/ant-apache-oro-1.8.1.ebuild,v 1.5 2010/11/05 02:59:23 halcy0n Exp $

EAPI=1

ANT_TASK_DEPNAME="jakarta-oro-2.0"

inherit ant-tasks

KEYWORDS="amd64 ~ia64 ~ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=dev-java/jakarta-oro-2.0.8-r2:2.0"
RDEPEND="${DEPEND}"
