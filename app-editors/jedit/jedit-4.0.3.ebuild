# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Maik Schreiber <bZ@iq-computing.de>
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.0.3.ebuild,v 1.1 2002/07/02 17:53:57 rphillips Exp $

S="${WORKDIR}/jEdit"
DESCRIPTION="Programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
LICENSE="GPL-2"
DEPEND=">=dev-java/ant-1.4.1 >=dev-java/jikes-1.15"
RDEPEND=">=virtual/jdk-1.3"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/jedit/jedit403source.tar.gz"

src_compile() {
	einfo "Please ignore the following compiler warnings."
	einfo "Jikes is just too pedantic..."
	ant -Dbuild.compiler=jikes || die "compile problem"
}

src_install () {
	mkdir -m 755 -p ${D}/usr/share/jedit
	mkdir -m 755 ${D}/usr/bin

	cp -R jedit.jar jars macros modes properties startup ${D}/usr/share/jedit
	cd ${D}/usr/share/jedit
	chmod -R u+rw,ug-s,go+u,go-w \
		jedit.jar jars macros modes properties startup

	cat >${D}/usr/share/jedit/jedit.sh <<-EOF
		#!/bin/bash

		cd /usr/share/jedit
		java -jar /usr/share/jedit/jedit.jar $@
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
