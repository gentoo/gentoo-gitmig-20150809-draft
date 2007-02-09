# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-tasks/ant-tasks-1.7.0.ebuild,v 1.7 2007/02/09 18:58:58 betelgeuse Exp $

inherit java-pkg-2 eutils

DESCRIPTION="Meta-package for Apache Ant's optional tasks."
HOMEPAGE="http://ant.apache.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="jai javamail noantlr nobcel nobsf nocommonsnet nocommonslogging nojdepend
	nojmf nojsch nolog4j nooro noregexp noresolver noswing noxalan"
# nobeanutils nobsh nojython norhino noxerces

RDEPEND=">=virtual/jre-1.4
	~dev-java/ant-core-${PV}
	~dev-java/ant-nodeps-${PV}
	~dev-java/ant-junit-${PV}
	!dev-java/ant-optional
	!noantlr? ( ~dev-java/ant-antlr-${PV} )
	!nobcel? ( ~dev-java/ant-apache-bcel-${PV} )
	!nobsf? ( ~dev-java/ant-apache-bsf-${PV} )
	!nolog4j? ( ~dev-java/ant-apache-log4j-${PV} )
	!nooro? ( ~dev-java/ant-apache-oro-${PV} )
	!noregexp? ( ~dev-java/ant-apache-regexp-${PV} )
	!noresolver? ( ~dev-java/ant-apache-resolver-${PV} )
	!nocommonslogging? ( ~dev-java/ant-commons-logging-${PV} )
	!nocommonsnet? ( ~dev-java/ant-commons-net-${PV} )
	jai? ( ~dev-java/ant-jai-${PV} )
	javamail? ( ~dev-java/ant-javamail-${PV} )
	!nojdepend? ( ~dev-java/ant-jdepend-${PV} )
	!nojmf? ( ~dev-java/ant-jmf-${PV} )
	!nojsch? ( ~dev-java/ant-jsch-${PV} )
	!noswing? ( ~dev-java/ant-swing-${PV} )
	!noxalan? ( ~dev-java/ant-trax-${PV} )"

# 	TODO: consider those
# 	!noxerces? ( >=dev-java/xerces-2.6.2-r1 )
# 	!nobsh? ( >=dev-java/bsh-1.2-r7 )
# 	!nobeanutils? ( =dev-java/commons-beanutils-1.6* )
# 	!norhino? ( =dev-java/rhino-1.5* )
# 	!nojython? ( >=dev-java/jython-2.1-r5 )

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S="${WORKDIR}"

src_compile() { :; }

my_reg_jars() {
	# Recording jars to get the same behaviour as before
	local oldifs="${IFS}"
	IFS=":"
	for jar in $(java-pkg_getjars ${1}); do
		java-pkg_regjar "${jar}"
		dosym ${jar} /usr/share/${PN}/lib/
	done
	IFS="${oldifs}"
}

src_install() {
	use !noantlr && my_reg_jars ant-antlr
	use !nobcel && my_reg_jars ant-apache-bcel
	use !nobsf && my_reg_jars ant-apache-bsf
	use !nolog4j && my_reg_jars ant-apache-log4j
	use !nooro && my_reg_jars ant-apache-oro
	use !noregexp && my_reg_jars ant-apache-regexp
	use !noresolver && my_reg_jars ant-apache-resolver
	use !nocommonslogging && my_reg_jars ant-commons-logging
	use !nocommonsnet && my_reg_jars ant-commons-net
	use jai && my_reg_jars ant-jai
	use javamail && my_reg_jars ant-javamail
	use !nojdepend && my_reg_jars ant-jdepend
	use !nojmf && my_reg_jars ant-jmf
	use !nojsch && my_reg_jars ant-jsch
	my_reg_jars ant-junit
	use !noswing && my_reg_jars ant-swing
	use !noxalan && my_reg_jars ant-trax
}

pkg_postinst() {
	local noset=false
	for x in ${IUSE} ; do
		if [ "${x:0:2}" == "no" ] ; then
			use ${x} && noset=true
		fi
	done
	if [ ${noset} == "true" ]; then
		ewarn "You have disabled some of the ant tasks. Be advised that this may"
		ewarn "break building some of the Java packages!!"
		ewarn ""
		ewarn "We can only offer very limited support in cases where dev-java/ant-tasks"
		ewarn "has been build with essential features disabled."
	fi
}
