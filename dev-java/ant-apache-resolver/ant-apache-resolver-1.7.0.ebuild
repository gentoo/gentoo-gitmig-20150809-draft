# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-resolver/ant-apache-resolver-1.7.0.ebuild,v 1.1 2007/01/21 22:47:51 caster Exp $

ANT_TASK_DEPNAME="xml-commons-resolver"

inherit ant-tasks

KEYWORDS="~x86"

DEPEND=">=dev-java/xml-commons-resolver-1.1-r1"
RDEPEND="${DEPEND}"
