# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-1.0.0_rc2-r1.ebuild,v 1.1 2007/05/24 18:49:04 nichoj Exp $

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
	dev-java/backport-util-concurrent
	!<dev-java/jruby-1.0.0_rc2-r1"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	test? (
		=dev-java/junit-3*
		dev-java/ant-junit
		dev-java/ant-trax
	)
	${COMMON_DEPEND}"
PDEPEND="dev-ruby/rubygems"

S="${WORKDIR}/${MY_P}"

EANT_DOC_TARGET="create-apidocs"

# only use javac, see http://jira.codehaus.org/browse/JRUBY-675
JAVA_PKG_FILTER_COMPILER="ecj-3.2 ecj-3.1 jikes"

RUBY_HOME=/usr/share/${PN}/lib/ruby
SITE_RUBY=${RUBY_HOME}/site_ruby
GEMS=${RUBY_HOME}/gems

pkg_setup() {
	java-pkg-2_pkg_setup

	if [[ -d ${SITE_RUBY} ]]; then
		ewarn "dev-java/jruby now uses dev-lang/ruby's site_ruby directory by creating symlinks."
		ewarn "${SITE_RUBY} is a directory right now, which will cause problems when being merged onto the filesystem."
	fi
	if [[ -d ${GEMS} ]]; then
		ewarn "dev-java/jruby now uses dev-lang/ruby's gems directory by creating symlinks."
		ewarn "${GEMS} is a directory right now, which will cause problems when being merged onto the filesystem."
	fi
}

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
	eant jar $(use_doc create-apidocs) -Djruby.home=${T}/.jruby
}

src_install() {
	java-pkg_dojar lib/${PN}.jar

	dodoc README docs/{*.txt,README.*,BeanScriptingFramework} || die
	dohtml docs/getting_involved.html || die

	if use doc; then
		java-pkg_dojavadoc docs/api
	fi
	use source && java-pkg_dosrc src/org
	java-pkg_dolauncher ${PN} \
		--main 'org.jruby.Main' \
		--java_args '-Djruby.base=/usr/share/jruby -Djruby.home=/usr/share/jruby -Djruby.lib=/usr/share/jruby/lib -Djruby.script=jruby -Djruby.shell=/bin/sh'
	dobin ${S}/bin/jirb

	dodir "/usr/share/${PN}/lib"
	insinto "/usr/share/${PN}/lib"
	doins -r "${S}/lib/ruby"

	# Share gems with regular ruby
	rm -r ${D}/usr/share/${PN}/lib/ruby/gems || die
	dosym /usr/lib/ruby/gems /usr/share/${PN}/lib/ruby/gems || die

	# Share site_ruby with regular ruby
	rm -r ${D}/usr/share/${PN}/lib/ruby/site_ruby || die
	dosym /usr/lib/ruby/site_ruby /usr/share/${PN}/lib/ruby/site_ruby || die
}

pkg_preinst() {
	if [[ -d ${SITE_RUBY} || -d ${GEMS} ]]; then
		if [[ -d ${SITE_RUBY} ]]; then
	 		eerror "${SITE_RUBY} is a directory. Please move this directory out of the way, and then emerge --resume."
		fi
		if [[ -d ${GEMS} ]]; then
			eerror "${GEMS} is a directory. Please move this directory out of the way, and then emerge --resume."
		fi
		die "Please address the above errors, then emerge --resume."
	fi
}

src_test() {
	ANT_TASKS="ant-junit ant-trax" eant test
}
