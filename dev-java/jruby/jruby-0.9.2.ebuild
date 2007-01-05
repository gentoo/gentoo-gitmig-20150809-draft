# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-0.9.2.ebuild,v 1.1 2007/01/05 04:24:29 nichoj Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java based ruby interpreter implementation"
HOMEPAGE="http://jruby.codehaus.org/"
SRC_URI="http://dist.codehaus.org/${PN}/${PN}-src-${PV}.tar.gz"

LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source test"

COMMON_DEPEND=">=dev-java/jvyaml-0.2
	dev-java/jline
	=dev-java/asm-2.2*
	=dev-java/bsf-2.3*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	!test? ( dev-java/ant-core )
	test? (
		dev-java/junit
		dev-java/ant
	)
	source? ( app-arch/zip )
	${COMMON_DEPEND}"

EANT_DOC_TARGET="create-apidocs"

src_unpack() {
	unpack ${A}
	cd ${S}

	# 0.9.2 was using a version of jline which hasn't been released, which has
	# a few new methods. disabling calls to those methods, but shouldn't affect
	# usablility. see
	#	http://jira.codehaus.org/browse/JRUBY-383
	epatch ${FILESDIR}/${P}-old_jline.patch
	# fix javadoc, make tests halt on failure
	epatch ${FILESDIR}/${P}-haltonfailure.patch

	cd lib
	# created by jruby dev, but no source available, so use bundled
	mv plaincharset.jar "${T}"
	rm -rf *.jar
	mv "${T}/plaincharset.jar" .

	java-pkg_jar-from --build-only ant-core ant.jar
	java-pkg_jar-from asm-2.2 asm.jar
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from jvyaml
	java-pkg_jar-from jline
	use test && java-pkg_jar-from --build-only junit
}

src_install() {
	java-pkg_dojar "lib/${PN}.jar" "lib/plaincharset.jar"

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
	eant test
}
