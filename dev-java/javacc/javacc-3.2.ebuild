# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacc/javacc-3.2.ebuild,v 1.1 2004/02/27 15:24:24 zx Exp $

DESCRIPTION="Java Compiler Compiler [tm] (JavaCC [tm]) - The Java Parser Generator"
HOMEPAGE="https://javacc.dev.java.net/servlets/ProjectHome"
SRC_URI="${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

RDEPEND="virtual/jre"

pkg_nofetch() {
	einfo "Please goto ${HOMEPAGE} and download ${SRC_URI}"
	einfo "Place it into: "
	einfo "     ${DISTDIR}"
}

src_install() {
	dohtml doc/*
	dodir /opt/${P}/bin/lib

	into /opt/${P}
	dodir /usr/bin
	for i in javacc jjdoc jjtree ; do
		echo "#!/bin/sh" > bin/$i
		echo "java -classpath /opt/${P}/bin/lib/javacc.jar $i \$*" >> bin/$i
		dobin bin/$i
		dosym /opt/${P}/bin/$i /usr/bin
	done
	insinto /opt/${P}/bin/lib
	doins bin/lib/*

	# no recursive doins available:
	for i in `find examples -type d` ; do
		dodir /opt/${P}/$i
		insinto /opt/${P}/$i
		FILES=`find $i -type f -maxdepth 1`
		if [ ! "${FILES}" == "" ] ; then
			doins ${FILES}
		fi
	done

	dodir /etc/env.d
	echo "JAVACC_HOME=\"/opt/${P}\"" > ${D}/etc/env.d/70javacc
}

pkg_postinst () {
	einfo
	einfo "An environment variable JAVACC_HOME has been set up."
	einfo
}

