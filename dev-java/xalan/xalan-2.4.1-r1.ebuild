# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xalan/xalan-2.4.1-r1.ebuild,v 1.2 2003/02/13 10:23:37 vapier Exp $

inherit virtualx

S=${WORKDIR}/${PN}-j_2_4_1
DESCRIPTION="XSLT processor"
HOMEPAGE="http://xml.apache.org/xalan-j/index.html"
SRC_URI="http://xml.apache.org/dist/xalan-j/${PN}-j_2_4_1-src.tar.gz"
LICENSE="Apache-1.1"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4.1
	>=dev-java/xerces-2.2.0"
RDEPEND="$DEPEND"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	export maketype="ant"
	CP=`echo bin/*.jar | tr " " ":"`
	export CLASSPATH=$CLASSPATH:$CP

	virtualmake jar docs ${myc} || die "build failed"

	if [ `java-config --java-version 2>&1 | grep "1\.4\."  | wc -l` -lt 1 ]  ; then
		virtualmake javadocs || die "Build Javadocs Failed"
	fi
}

src_install () {
	dojar build/xalan.jar
	dohtml readme.html
	dohtml -r build/docs/*
}

pkg_postinst() {
		einfo "API Docs: http://xml.apache.org/xalan-j/apidocs/index.html"
}
