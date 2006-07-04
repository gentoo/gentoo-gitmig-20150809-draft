# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-daemon/commons-daemon-1.0.1.ebuild,v 1.6 2006/07/04 05:26:13 squinky86 Exp $

inherit java-pkg eutils

DESCRIPTION="Tools to allow java programs to run as unix daemons"
SRC_URI="mirror://apache/jakarta/commons/daemon/source/daemon-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/commons/daemon/"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc examples jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/daemon-${PV}

src_unpack() {
	unpack ${A}

	# Submitted upstream to http://bugs.gentoo.org/show_bug.cgi?id=132563
	epatch "${FILESDIR}/1.0.1-as-needed.patch"

	cd ${S}/src/native/unix
	sed -e "s/powerpc/powerpc|powerpc64/g" -i support/apsupport.m4
	export WANT_AUTOCONF="2.5"
	autoconf
}

src_compile() {
	# compile native stuff
	cd ${S}/src/native/unix
	econf || die "configure failed"
	emake || die "make failed"

	# compile java stuff
	cd ${S}
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation problem"
}

src_install() {
	dobin src/native/unix/jsvc
	java-pkg_dojar dist/${PN}.jar || die "Unable to install"

	dodoc README RELEASE-NOTES.txt *.html
	use doc && java-pkg_dohtml -r dist/docs/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R src/samples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/java/* src/native/unix/native
}
