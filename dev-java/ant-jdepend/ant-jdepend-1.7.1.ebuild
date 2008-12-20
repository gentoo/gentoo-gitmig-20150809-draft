# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-jdepend/ant-jdepend-1.7.1.ebuild,v 1.2 2008/12/20 16:19:27 nixnut Exp $

EAPI=1

inherit ant-tasks

KEYWORDS="~amd64 ~ia64 ppc ~ppc64 ~x86 ~x86-fbsd"

DEPEND=">=dev-java/jdepend-2.9-r2:0"
RDEPEND="${DEPEND}"
