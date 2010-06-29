# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-jai/ant-jai-1.8.1.ebuild,v 1.2 2010/06/29 09:03:24 angelos Exp $

ANT_TASK_DEPNAME="sun-jai-bin"

inherit ant-tasks

KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

# unmigrated, has textrels and there's also some source one now too
DEPEND=">=dev-java/sun-jai-bin-1.1.2.01-r1"
RDEPEND="${DEPEND}"
