# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-antlr/ant-antlr-1.7.0.ebuild,v 1.12 2009/01/03 15:55:36 armin76 Exp $

inherit java-pkg-2 ant-tasks

KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

DEPEND=">=dev-java/antlr-2.7.5-r3"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use dev-java/antlr java; then
		msg="dev-java/antlr needs to be built with the java use flag"
		eerror ${msg}
		die ${msg}
	fi
	java-pkg-2_pkg_setup
}
