# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-nodeps/ant-nodeps-1.7.0.ebuild,v 1.1 2007/01/21 22:05:49 caster Exp $

inherit ant-tasks

DESCRIPTION="Apache Ant's optional tasks requiring no external deps"
KEYWORDS="~x86"

src_unpack() {
	ant-tasks_src_unpack base
	java-pkg_jar-from --build-only ant-core ant-launcher.jar
}

src_compile() {
	eant jar-nodeps
}
