# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/groovy/groovy-1.0_beta4-r1.ebuild,v 1.7 2005/01/20 18:29:26 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Groovy is a high-level dynamic language for the JVM"
HOMEPAGE="http://groovy.codehaus.org/"
SRC_URI="http://dist.codehaus.org/groovy/distributions/${PN}-1.0-beta-4-src.tar.gz"
LICENSE="codehaus-groovy"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"
DEPEND="=dev-java/xerces-2.6* \
	>=dev-java/commons-cli-1.0-r3
	>=dev-java/ant-1.5*
	=dev-java/junit-3.8*
	=dev-java/asm-1.4*
	>=dev-java/classworlds-1.0-r2
	=dev-java/mockobjects-0.0*
	=dev-java/bsf-2.3*
	=dev-java/servletapi-2.4*
	=dev-java/xmojo-bin-5.0*
	jikes? ( dev-java/jikes )"
# karltk:
# xmojo-bin is a JMX provider, we should add a list of alternatives


S=${WORKDIR}/${PN}-1.0-beta-4

src_unpack() {
	unpack ${A}

	mkdir -p ${S}/target/lib

	cd ${S}/target/lib
	java-pkg_jar-from xerces-2 || die "Missing xerces"
	java-pkg_jar-from junit || die "Missing junit"
	java-pkg_jar-from asm-1.4 || die "Missing asm"
	java-pkg_jar-from commons-cli-1 || die "Missing commons-cli"
	java-pkg_jar-from classworlds-1 || die "Missing classworlds"
	java-pkg_jar-from bsf-2.3 || die "Missing bsf"
	java-pkg_jar-from mockobjects || die "Missing mockobjects"
	java-pkg_jar-from xmojo-bin-5.0 || die "Missing xmojo-bin"
	java-pkg_jar-from servletapi-2.4 servlet-api.jar || die "Missing servletapi"

	cd ${S}

	# The original build.xml will only build on a MacOSX machine when you're
	# logged in as jstrachan. I don't reckon many Gentoo users are...
	cp ${FILESDIR}/build.xml-${PV} ${S}/build.xml || die "Failed to update build.xml"

	# This won't compile without an incestuous relationship with radeox.
	rm -rf ${S}/src/main/org/codehaus/groovy/wiki
}

src_compile() {
	local myconf
	use jikes && myconf="${myconf} -Dbuild.compiler=jikes"

	ant ${myconf} jar || die "Failed to compile jar"
	if use doc ; then
		ant javadoc || die "Failed to generate docs"
	fi

	# Generate command-line scripts
	for x in grok groovy groovyc groovysh groovyConsole ; do
		generate_script $x
	done

	cd src/main
	sh groovyc \
		--classpath ../../target/classes/ \
		groovy/ui/Console.groovy || die "Failed to invoke groovyc"

	jar uf ../../target/groovy-1.0-beta-4.jar groovy/ui/Console*.class || die "Failed to backpatch Console*.class"
}

generate_script() {
	scriptname=$1
	classworlds_classpath="$(java-config -p classworlds-1)"
	asm_classpath="$(java-config -p asm-1)"
	bsf_classpath="$(java-config -p bsf-2.3)"
	classworlds_classpath="$(java-config -p classworlds-1)"
	commons_cli_classpath="$(java-config -p commons-cli-1)"
	mockobjects_classpath="$(java-config -p mockobjects)"
	xerces_classpath="$(java-config -p xerces-2)"
	xmojo_classpath="$(java-config -p xmojo-bin-5.0)"

	sed -e "s;@scriptname@;${scriptname};" \
		-e "s;@groovy-home@;/usr/share/groovy-${SLOT};" \
		-e "s;@classworlds_classpath@;${classworlds_classpath};" \
		-e "s;@asm_classpath@;${asm_classpath};" \
		-e "s;@bsf_classpath@;${bsf_classpath};" \
		-e "s;@commons_cli_classpath@;${commons_cli_classpath};" \
		-e "s;@mockobjects_classpath@;${mockobjects_classpath};" \
		-e "s;@xerces_classpath@;${xerces_classpath};" \
		-e "s;@xmojo_classpath@;${xmojo_classpath};" \
		< ${FILESDIR}/basescript-${PV} \
		> ${scriptname} || die "Failed to generate ${scriptname}"
}

src_install() {

	# Install misc. documentation
	dodoc LICENSE.txt

	# Install jar files
	java-pkg_dojar target/groovy-1.0-beta-4.jar

	# Install API documentation
	if use doc ; then
		java-pkg_dohtml -r dist/docs/api
	fi

	# Install configuration files
	confdir=/usr/share/groovy-${SLOT}/conf
	dodir ${confdir}
	insinto ${confdir}
	doins src/conf/{groovy,groovyc,groovysh,groovyConsole,grok}-classworlds.conf

	# Install command-line scripts
	exeinto /usr/bin
	for x in grok groovy groovyc groovysh groovyConsole ; do
		doexe $x || die "Failed to install ${x}"
	done
}
