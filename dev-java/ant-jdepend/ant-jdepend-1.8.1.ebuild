# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-jdepend/ant-jdepend-1.8.1.ebuild,v 1.6 2011/05/03 19:01:30 grobian Exp $

EAPI=1

inherit ant-tasks

KEYWORDS="amd64 ~ia64 ~ppc ppc64 x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=dev-java/jdepend-2.9-r2:0"
RDEPEND="${DEPEND}"
