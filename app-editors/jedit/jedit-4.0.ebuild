# Copyright 2002 Maik Schreiber
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.0.ebuild,v 1.1 2002/06/10 01:30:58 rphillips Exp $

S="${WORKDIR}/jEdit"
DESCRIPTION="A programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
LICENSE="GPL-2"
DEPEND=">=dev-java/ant-1.4.1 >=dev-java/jikes-1.15"
RDEPEND=">=virtual/jdk-1.3"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/jedit/jedit40source.tar.gz"

src_compile() {
	ant -Dbuild.compiler=jikes || die
}

src_install () {
	mkdir -m 755 -p ${D}/usr/jedit
	mkdir -m 755 ${D}/usr/bin

	cp -R jedit.jar jars macros modes properties startup ${D}/usr/jedit
	chmod -R u+rw,ug-s,go+u,go-w \
		${D}/usr/jedit/jedit.jar \
		${D}/usr/jedit/jars \
		${D}/usr/jedit/macros \
		${D}/usr/jedit/modes \
		${D}/usr/jedit/properties \
		${D}/usr/jedit/startup

	cat >${D}/usr/jedit/jedit.sh <<-EOF
		#!/bin/bash

		cd /usr/jedit
		java -jar /usr/jedit/jedit.jar $@
	EOF

	chmod 755 ${D}/usr/jedit/jedit.sh

	ln -s ../jedit/jedit.sh ${D}/usr/bin/jedit
}
