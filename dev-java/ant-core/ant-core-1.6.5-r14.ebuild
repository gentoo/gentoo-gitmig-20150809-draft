# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-core/ant-core-1.6.5-r14.ebuild,v 1.10 2006/12/09 12:52:38 caster Exp $

inherit java-pkg-2 eutils toolchain-funcs java-ant-2

MY_PN=${PN/-core}

DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
HOMEPAGE="http://ant.apache.org/"
SRC_URI="mirror://apache/ant/source/apache-${MY_PN}-${PV}-src.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc source"

DEPEND="source? ( app-arch/zip )
	>=virtual/jdk-1.4
	!<dev-java/ant-tasks-${PV}
	!dev-java/ant-optional"
RDEPEND=">=virtual/jdk-1.4
	>=dev-java/java-config-1.2"

S="${WORKDIR}/apache-ant-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch build.sh to die with non-zero exit code in case of errors.
	# This patch may be useful for all ant versions.
	epatch "${FILESDIR}/build.sh-exit-fix.patch"
}

src_compile() {
	if [[ $(tc-arch) == "ppc" ]] ; then
		# We're compiling _ON_ PPC
		export THREADS_FLAG="green"
	fi

	./build.sh -Ddist.dir="${D}/usr/share/${PN}" || die "failed to build"

	if use doc; then
		./build.sh dist_javadocs || die "failed to build docs"
	fi
}

src_install() {
	newbin "${FILESDIR}/${PV}-ant" ant || die "failed to install wrapper"

	dodir "/usr/share/${PN}/bin"
	for each in antRun runant.pl runant.py complete-ant-cmd.pl ; do
		dobin "${S}/src/script/${each}"
		dosym "/usr/bin/${each}" "/usr/share/${PN}/bin/${each}"
	done

	dodir /etc/env.d
	echo "ANT_HOME=\"/usr/share/${PN}\"" > "${D}/etc/env.d/20ant"

	java-pkg_dojar build/lib/ant.jar
	java-pkg_dojar build/lib/ant-launcher.jar

	use source && java-pkg_dosrc src/main/*

	dodoc README WHATSNEW KEYS

	if use doc; then
		dohtml welcome.html
		java-pkg_dohtml -r docs/*
		java-pkg_dohtml -r dist/docs/*
	fi
}
