# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-jai/ant-jai-1.7.0.ebuild,v 1.10 2007/05/12 18:17:39 wltjr Exp $

ANT_TASK_DEPNAME="sun-jai-bin"

inherit ant-tasks

KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"

# unmigrated, has textrels and there's also some source one now too
DEPEND=">=dev-java/sun-jai-bin-1.1.2.01-r1"
RDEPEND="${DEPEND}"
