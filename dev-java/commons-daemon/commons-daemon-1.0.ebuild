# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-daemon/commons-daemon-1.0.ebuild,v 1.2 2004/03/23 03:18:10 zx Exp $

inherit java-pkg

DESCRIPTION="Tools to allow java programs to run as unix daemons"
SRC_URI="ftp://ftp.ibiblio.org/pub/mirrors/apache/jakarta/commons/daemon/source/daemon-1.0-Alpha.tar.gz"
HOMEPAGE="http://jakarta.apache.org/commons/daemon/"
LICENSE="Apache-1.1"
SLOT="0"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.4
		virtual/glibc"
KEYWORDS="x86"
IUSE="jikes doc"

S=${WORKDIR}/daemon-${PV}-Alpha

src_compile() {
	cd src/native/unix
	econf || die
	emake || die
	cd ${S}
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation problem"
}

src_install () {
	dobin src/native/unix/jsvc
	java-pkg_dojar dist/${PN}.jar || die "Unable to install"
	dodoc README RELEASE-NOTES.txt *.html
	cp -R src/samples ${D}/usr/share/doc/${P}/
	use doc && dohtml -r dist/docs/*
}
