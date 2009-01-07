# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-bsf/ant-apache-bsf-1.7.1-r1.ebuild,v 1.2 2009/01/07 19:05:11 ranger Exp $

EAPI=2

ANT_TASK_DEPNAME="bsf-2.3"

inherit eutils ant-tasks

KEYWORDS="~amd64 ~ia64 ~ppc ppc64 ~x86 ~x86-fbsd"

# ant-nodeps contains <script> task which is needed for this
# although it's not a build dep through import
DEPEND=">=dev-java/bsf-2.4.0-r1:2.3[python?,javascript?,tcl?]"
RDEPEND="${DEPEND}
	~dev-java/ant-nodeps-${PV}"

IUSE="python javascript tcl"

JAVA_PKG_FILTER_COMPILER="jikes"

src_install() {
	ant-tasks_src_install
	java-pkg_register-dependency ant-nodeps
}

pkg_postinst() {
	elog "Also, >=dev-java/bsf-2.4.0-r1 adds optional support for groovy,"
	elog "ruby and beanshell. See its postinst elog messages for instructions."
}
