# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.2_pre8.ebuild,v 1.2 2004/01/01 05:55:02 anti Exp $

MY_PV="42pre8"

DESCRIPTION="Programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
SRC_URI="mirror://sourceforge/jedit/jedit${MY_PV}source.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"
IUSE="jikes"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	>=dev-java/ant-1.4.1
	jikes? ( >=dev-java/jikes-1.17 )"

S="${WORKDIR}/jEdit"

src_compile() {
	local antflags

	if [ -z "$JAVA_HOME" ]; then
		einfo
		einfo "\$JAVA_HOME not set!"
		einfo "Please use java-config to configure your JVM and try again."
		einfo
		die "\$JAVA_HOME not set."
	fi

	antflags=""
	if [ `use jikes` ] ; then
		einfo "Please ignore the following compiler warnings."
		einfo "Jikes is just too pedantic..."
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi

	ant ${antflags} || die "compile problem"
}

src_install () {
	dodir /usr/share/jedit
	dodir /usr/bin

	cp -R jedit.jar jars doc macros modes properties startup ${D}/usr/share/jedit
	cd ${D}/usr/share/jedit
	chmod -R u+rw,ug-s,go+u,go-w \
		jedit.jar jars doc macros modes properties startup

	cat >${D}/usr/share/jedit/jedit.sh <<-EOF
		#!/bin/bash

		java -jar /usr/share/jedit/jedit.jar \$@
	EOF
	chmod 755 ${D}/usr/share/jedit/jedit.sh

	ln -s ../share/jedit/jedit.sh ${D}/usr/bin/jedit
}

pkg_postinst() {
	touch /usr/share/jedit/jars/.keep

	einfo "The system directory for jEdit plugins is"
	einfo "/usr/share/jedit/jars"
}

pkg_postrm() {
	einfo "jEdit plugins installed into /usr/share/jedit/jars"
	einfo "(after installation of jEdit itself) haven't been"
	einfo "removed. To get rid of jEdit completely, you may"
	einfo "want to run"
	einfo ""
	einfo "\trm -r /usr/share/jedit"
}
