# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/groovy/groovy-1.0_beta4-r2.ebuild,v 1.1 2006/08/26 14:52:56 betelgeuse Exp $

inherit java-pkg-2 java-ant-2


MY_PV=${PV/_beta/-beta-}

DESCRIPTION="Groovy is a high-level dynamic language for the JVM"
HOMEPAGE="http://groovy.codehaus.org/"
SRC_URI="http://dist.codehaus.org/groovy/distributions/${PN}-${MY_PV}-src.tar.gz"
LICENSE="codehaus-groovy"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

# karltk:
# xmojo-bin is a JMX provider, we should add a list of alternatives

# betelgeuse:
# Looking at the project.xml, the deps could use some improvement
COMMON_DEP="
	=dev-java/asm-1.4.1*
	=dev-java/bsf-2.3*
	>=dev-java/commons-cli-1.0-r3
	=dev-java/junit-3.8*
	=dev-java/mockobjects-0.0*
	=dev-java/servletapi-2.4*
	>=dev-java/xerces-2.6
	>=dev-java/classworlds-1.0-r2
	=dev-java/xmojo-bin-5.0*
"
#	>=dev-java/xerces-2.6
#	>=dev-java/classworlds-1.0-r2
#	=dev-java/xmojo-bin-5.0*

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}
	>=dev-java/ant-core-1.6.2"


S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}

	mkdir -p ${S}/target/lib

	cd ${S}/target/lib
#	java-pkg_jar-from xerces-2
	java-pkg_jar-from junit
	java-pkg_jar-from asm-1.4.1
	java-pkg_jar-from commons-cli-1
#	java-pkg_jar-from classworlds-1
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from mockobjects
#	java-pkg_jar-from xmojo-bin-5.0
	java-pkg_jar-from ant-core
	java-pkg_jar-from servletapi-2.4 servlet-api.jar

	cd ${S}

	# The original build.xml will only build on a MacOSX machine when you're
	# logged in as jstrachan. I don't reckon many Gentoo users are...
	cp ${FILESDIR}/build.xml-${PV} ${S}/build.xml || die "Failed to update build.xml"

	# This won't compile without an incestuous relationship with radeox.
	rm -rf ${S}/src/main/org/codehaus/groovy/wiki
}

src_compile() {
	eant $(use_doc) jar || die "Failed to compile jar"

	# Generate command-line scripts
	for x in grok groovy groovyc groovysh groovyConsole ; do
		generate_script "$x" "${S}/src" ":${S}/target/classes"
	done

	mkdir src/lib
	cd src/main
	sh ${S}/groovyc groovy/ui/Console.groovy || die "Failed to invoke groovyc"

	jar uf ../../target/${PN}-${MY_PV}.jar groovy/ui/Console*.class || die "Failed to backpatch Console*.class"
}


# Should migrate to dolauncher
generate_script() {
	scriptname="${1}"
	classworlds_classpath="$(java-config -p classworlds-1)"
	asm_classpath="$(java-config -p asm-1.4.1)"
	bsf_classpath="$(java-config -p bsf-2.3)"
	classworlds_classpath="$(java-config -p classworlds-1)"
	commons_cli_classpath="$(java-config -p commons-cli-1)"
	mockobjects_classpath="$(java-config -p mockobjects)"
	xerces_classpath="$(java-config -p xerces-2)"
	xmojo_classpath="$(java-config -p xmojo-bin-5.0)"

	if [[ -n ${2} ]]; then
		local groovy_home="${2}"
	else
		local groovy_home="/usr/share/groovy-${SLOT}"
	fi
	sed -e "s;@scriptname@;${scriptname};" \
		-e "s;@groovy-home@;${groovy_home};" \
		-e "s;@classworlds_classpath@;${classworlds_classpath};" \
		-e "s;@asm_classpath@;${asm_classpath};" \
		-e "s;@bsf_classpath@;${bsf_classpath};" \
		-e "s;@commons_cli_classpath@;${commons_cli_classpath};" \
		-e "s;@mockobjects_classpath@;${mockobjects_classpath};" \
		-e "s;@xerces_classpath@;${xerces_classpath};" \
		-e "s;@xmojo_classpath@;${xmojo_classpath};" \
		-e "s;@extra_classpath@;${3};" \
		< ${FILESDIR}/basescript-${PV} \
		> ${scriptname} || die "Failed to generate ${scriptname}"
}

src_install() {
	java-pkg_newjar target/${PN}-${MY_PV}.jar

	use doc && java-pkg_dohtml -r dist/docs/api

	# Install configuration files
	confdir=/usr/share/groovy-${SLOT}/conf
	dodir ${confdir}
	insinto ${confdir}
	doins src/conf/{groovy,groovyc,groovysh,groovyConsole,grok}-classworlds.conf

	# Install command-line scripts
	exeinto /usr/bin

	for x in grok groovy groovyc groovysh groovyConsole ; do
		rm -f $x
		generate_script $x
		doexe $x || die "Failed to install ${x}"
	done
}
