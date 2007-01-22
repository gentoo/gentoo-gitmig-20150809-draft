# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-oro/ant-apache-oro-1.7.0.ebuild,v 1.3 2007/01/22 16:50:24 corsair Exp $

ANT_TASK_DEPNAME="jakarta-oro-2.0"

inherit ant-tasks

KEYWORDS="~ppc64 ~x86 ~x86-fbsd"

DEPEND=">=dev-java/jakarta-oro-2.0.8-r2"
RDEPEND="${DEPEND}"
