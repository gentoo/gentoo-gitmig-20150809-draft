# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-1.0.0_rc2.ebuild,v 1.1 2007/05/18 20:31:27 nichoj Exp $

JAVA_PKG_IUSE="doc source test"
inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV/_rc/RC}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Java based ruby interpreter implementation"
HOMEPAGE="http://jruby.codehaus.org/"
SRC_URI="http://dist.codehaus.org/${PN}/${PN}-src-${MY_PV}.tar.gz"

LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source test"

COMMON_DEPEND=">=dev-java/jline-0.9.91
	=dev-java/asm-2.2*
	>=dev-java/bsf-2.3
	dev-java/backport-util-concurrent"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	test? (
		=dev-java/junit-3*
		dev-java/ant-junit
		dev-java/ant-trax
	)
	${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

EANT_DOC_TARGET="create-apidocs"

# only use javac, see http://jira.codehaus.org/browse/JRUBY-675
JAVA_PKG_FILTER_COMPILER="ecj-3.2 ecj-3.1 jikes"

src_unpack() {
	unpack ${A}
	cd ${S}
	# prevents /root/.jruby being created at build time with
	# FEATURES="-userpriv"
	# see http://bugs.gentoo.org/show_bug.cgi?id=170058
	epatch ${FILESDIR}/${PN}-0.9.8-sandbox.patch

	cd ${S}/lib
	rm *.jar

	java-pkg_jar-from --build-only ant-core ant.jar
	java-pkg_jar-from asm-2.2 asm.jar
	java-pkg_jar-from asm-2.2 asm-commons.jar
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from jline
	java-pkg_jar-from backport-util-concurrent
	use test && java-pkg_jar-from --build-only junit
}

src_compile() {
#	addpredict /root/.jruby # http://bugs.gentoo.org/show_bug.cgi?id=170058
	eant jar $(use_doc create-apidocs) -Djruby.home=${T}/.jruby
}

src_install() {
	java-pkg_dojar lib/${PN}.jar

	dodoc README COPYING COPYING.CPL COPYING.GPL COPYING.LGPL

	if use doc; then
		java-pkg_dojavadoc docs/api
		docinto docs
		dodoc docs/*
	fi
	use source && java-pkg_dosrc src/org
	java-pkg_dolauncher ${PN} \
		--main 'org.jruby.Main' \
		--java_args '-Djruby.base=/usr/share/jruby -Djruby.home=/usr/share/jruby -Djruby.lib=/usr/share/jruby/lib -Djruby.script=jruby -Djruby.shell=/bin/sh'
	newbin ${S}/bin/gem jgem
	newbin ${S}/bin/gem_server jgem_server
	newbin ${S}/bin/gemlock jgem_lock
	newbin ${S}/bin/gemri jgemri
	newbin ${S}/bin/gemwhich jgemwhich
	newbin ${S}/bin/update_rubygems jupdate_rubygems
#	newbin ${S}/bin/generate_yaml_index.rb jgenerate_yaml_index.rb
	newbin ${S}/bin/index_gem_repository.rb jindex_gem_repository.rb
	dobin ${S}/bin/jirb

	dodir "/usr/share/${PN}/lib"
	insinto "/usr/share/${PN}/lib"
	doins -r "${S}/lib/ruby"
}

src_test() {
	ANT_TASKS="ant-junit ant-trax" eant test
}
