# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-bsf/ant-apache-bsf-1.7.0-r1.ebuild,v 1.1 2007/05/24 20:01:51 caster Exp $

ANT_TASK_DEPNAME="bsf-2.3"

inherit ant-tasks eutils

KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"

# ant-nodeps contains <script> task which is needed for this
# although it's not a build dep through import
DEPEND=">=dev-java/bsf-2.3.0-r3"
RDEPEND="${DEPEND}
	~dev-java/ant-nodeps-${PV}"

JAVA_PKG_FILTER_COMPILER="jikes"

src_install() {
	ant-tasks_src_install
	java-pkg_register-dependency ant-nodeps
}

built_with_use_warn() {
	if ! built_with_use --missing false dev-java/bsf ${1}; then
		elog "dev-java/bsf is not installed with \"${1}\" useflag"
		elog "You won't be able to use ${2} with <script> task in build.xml files."
	fi
}

pkg_postinst() {
	built_with_use_warn python Python
	built_with_use_warn rhino JavaScript
	built_with_use_warn tcl TCL
}
