# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.0.3-r2.ebuild,v 1.2 2002/08/06 17:34:16 blizzy Exp $

S="${WORKDIR}/jEdit"
DESCRIPTION="Programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/jedit/jedit403source.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	>=dev-java/ant-1.4.1"
#	jikes? ( >=dev-java/jikes-1.15 )"

src_compile() {
	local antflags

	antflags=""
#	if [ `use jikes` ] ; then
#		einfo "Please ignore the following compiler warnings."
#		einfo "Jikes is just too pedantic..."
#		antflags="${antflags} -Dbuild.compiler=jikes"
#	fi

	ant ${antflags} || die "compile problem"
}

src_install () {
	mkdir -m 755 -p ${D}/usr/share/jedit
	mkdir -m 755 ${D}/usr/bin

	cp -R jedit.jar jars doc macros modes properties startup ${D}/usr/share/jedit
	cd ${D}/usr/share/jedit
	chmod -R u+rw,ug-s,go+u,go-w \
		jedit.jar jars doc macros modes properties startup

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
