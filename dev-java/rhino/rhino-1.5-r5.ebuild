# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rhino/rhino-1.5-r5.ebuild,v 1.5 2004/06/19 23:23:42 karltk Exp $

inherit java-pkg

MY_P="rhino1_5R5"
DESCRIPTION="Rhino is an open-source implementation of JavaScript written entirely in Java. It is typically embedded into Java applications to provide scripting to end users"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.zip"
HOMEPAGE="http://www.mozilla.org/rhino/"
LICENSE="NPL-1.1"
SLOT="0"
# karltk: This is deprecated, but we can't just remove it, since we don't have a stable
# to replace it with.
KEYWORDS="-*"
IUSE="jikes doc"
S="${WORKDIR}/${MY_P%%RC1}"
DEPEND="dev-java/ant
		>=virtual/jdk-1.3
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"
RESTRICT="nomirror"

src_compile() {
	local antflags="jar"

	[ -n $http_proxy ] && proxyhost=`echo $http_proxy | sed -e "s/^\(.*\):\([0-9]*\)/\1/g" ` && \
	  proxyport=`echo $http_proxy | sed -e "s/^\(.*\):\([0-9]*\)/\2/g" ` && \
	  sed -e "s:<target name=\"get-swing-ex\" unless=\"swing-ex-available\">:&\n<setproxy proxyhost=\"${proxyhost}\" proxyport=\"${proxyport}\" />:g" \
	      -i toolsrc/build.xml

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation error"
}

src_install() {
	dobin ${FILESDIR}/jsscript
	java-pkg_dojar build/*/js.jar
	use doc && dohtml -r docs/*
}
