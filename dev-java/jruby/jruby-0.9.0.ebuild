# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-0.9.0.ebuild,v 1.1 2006/09/30 02:25:15 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java based ruby interpreter implementation"
HOMEPAGE="http://jruby.sourceforge.net/"
SRC_URI="mirror://sourceforge/jruby/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc test source"

RDEPEND=">=virtual/jre-1.4
	=dev-java/jvyaml-0.1*
	=dev-java/bsf-2.3*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-1.4
	test? ( dev-java/junit )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -rf *.jar
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from jvyaml
	use test && java-pkg_jar-from --build-only junit
}
src_compile() {
	eant jar $(use_doc create-apidocs)
}

src_test() {
	eant test
}

src_install() {
	java-pkg_dojar ${S}/lib/${PN}.jar

	dodoc README COPYING COPYING.CPL COPYING.GPL COPYING.LGPL

	if use doc; then
		java-pkg_dohtml -r docs/api/*
		docinto docs
		dodoc *.*
	fi
	use source && java-pkg_dosrc src/org
	java-pkg_dolauncher jruby \
		--main 'org.jruby.Main' \
		--java_args '-Djruby.base=/usr/share/jruby -Djruby.home=/usr/share/jruby -Djruby.lib=/usr/share/jruby/lib -Djruby.script=jruby -Djruby.shell=/bin/sh'
	newbin ${S}/bin/gem jgem
	newbin ${S}/bin/gem_server jgem_server
	newbin ${S}/bin/gemlock jgem_lock
	newbin ${S}/bin/gemri jgemri
	newbin ${S}/bin/gemwhich jgemwhich
	newbin ${S}/bin/update_rubygems jupdate_rubygems
	newbin ${S}/bin/generate_yaml_index.rb jgenerate_yaml_index.rb
	newbin ${S}/bin/index_gem_repository.rb jindex_gem_repository.rb
	dobin ${S}/bin/jirb

	dodir /usr/share/${PN}/lib
	cp -a ${S}/lib/*.jar
	insinto /usr/share/${PN}/lib
	doins -r ${S}/lib/ruby

}
