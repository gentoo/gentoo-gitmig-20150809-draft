# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/c-jdbc/c-jdbc-1.0.4-r1.ebuild,v 1.1 2005/03/27 17:18:02 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="Transparent Database Clustering Middleware"
HOMEPAGE="http://c-jdbc.objectweb.org"
SRC_URI="http://download.forge.objectweb.org/${PN}/${P}-src.tar.gz"
LICENSE="BSD"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes examples"
DEPEND=">=virtual/jdk-1.3
	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.3
	dev-java/ant
	=dev-java/commons-cli-1*
	=dev-java/crimson-1*
	=dev-java/dom4j-1.5*
	=dev-java/dtdparser-1.21*
	=dev-java/jaxen-1.1_beta2*
	>=dev-java/jcommon-0.9.7
	>=dev-java/jdepend-2.6
	>=dev-java/jdbc2-stdext-2.0*
	>=dev-java/jgroups-2.2.7
	=dev-java/jfreechart-0.9.21*
	>=dev-java/kunststoff-2.0.2
	>=dev-java/log4j-1.2.8
	=dev-java/mx4j-2.1*
	=dev-java/jakarta-regexp-1.3*
	>=dev-java/xalan-2.5.2
	~dev-java/xerces-2.6.2
	=dev-db/octopus-3.0*"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}/lib
	for i in `find . -name "*.jar"`
	do
		rm -f *.jar
	done

	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from crimson-1
	java-pkg_jar-from dtdparser-1.21
	java-pkg_jar-from jakarta-regexp-1.3
	java-pkg_jar-from jaxen-1.1
	java-pkg_jar-from jcommon
	java-pkg_jar-from jdbc2-stdext
	java-pkg_jar-from jfreechart
	java-pkg_jar-from kunststoff-2.0
	java-pkg_jar-from log4j
	java-pkg_jar-from jgroups
	java-pkg_jar-from dom4j-1

	cd ${S}/lib/jmx
	java-pkg_jar-from mx4j-2.1
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2 xml-apis.jar

	cd ${S}/lib/other
	java-pkg_jar-from jdepend

	cd ${S}/lib/octopus
	java-pkg_jar-from octopus-3.0
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	# install the jar file
	java-pkg_dojar build/jar/*.jar
	dodoc README.txt doc/HISTORY.txt doc/LICENSE.txt

	# install the controller config under /etc
	dodir /etc/c-jdbc
	cp -r config/controller/* ${D}/etc/c-jdbc
	rm -rf config/controller config/izpack

	# install the startup scripts
	newbin ${FILESDIR}/console.sh cjdbc-console
	newsbin ${FILESDIR}/controller.sh cjdbc-controller

	# init script und conf.d file
	dodir /etc/init.d
	cp ${FILESDIR}/cjdbc-init ${D}/etc/init.d/cjdbc

	dodir /etc/conf.d
	cp ${FILESDIR}/cjdbc-conf ${D}/etc/conf.d/cjdbc

	# directories which we need
	mv lib/jmx/xsl xsl
	local dir="config xml xsl"
	for i in ${dir}
	do
		cp -r ${i} ${D}usr/share/${PN}-${SLOT}
	done

	# an environment file to set the home directory
	dodir /etc/env.d/
	echo "CJDBC_HOME=/usr/share/${PN}-${SLOT}" > ${D}etc/env.d/20cjdbc

	# add a user for cjdbc
	if ! enewgroup cjdbc || ! enewuser cjdbc -1 /bin/sh /dev/null cjdbc; then
		die "Unable to add cjdbc user and cjdbc group."
	fi

	# we need a log directory
	dodir /var/log/c-jdbc
	touch ${D}/var/log/c-jdbc/cjdbc.log
	touch ${D}/var/log/c-jdbc/request.log
	fperms 775 /var/log/c-jdbc/cjdbc.log
	fperms 775 /var/log/c-jdbc/request.log
	fowners cjdbc:cjdbc /var/log/c-jdbc/cjdbc.log
	fowners cjdbc:cjdbc /var/log/c-jdbc/request.log


	# install the documentation and examples (depends on use-flags)
	if use doc; then
		java-pkg_dohtml -r build/doc/api/*
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r doc/examples/* ${D}usr/share/doc/${PF}/examples
	fi
}

pkg_postinst() {
	ewarn ""
	ewarn "Default config was placed in /etc/c-jdbc/controller.xml."
	ewarn "Edit this one to fit your needs or specify another filename"
	ewarn "in /etc/conf.d/cjdbc."
	ewarn ""
}
