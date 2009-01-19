# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/eclipse-ecj/eclipse-ecj-3.4-r3.ebuild,v 1.2 2009/01/19 20:30:38 betelgeuse Exp $

EAPI=2

inherit java-pkg-2

MY_PN="ecj"
DMF="R-${PV}-200806172000"
S="${WORKDIR}"

DESCRIPTION="Eclipse Compiler for Java"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/eclipse/downloads/drops/${DMF}/${MY_PN}src-${PV}.zip"

IUSE="gcj java6"

LICENSE="EPL-1.0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
SLOT="3.4"

CDEPEND=">=app-admin/eselect-ecj-0.3
	sys-devel/gcc[gcj?]"
DEPEND="${CDEPEND}
	app-arch/unzip
	!gcj? ( !java6? ( >=virtual/jdk-1.4 )
		java6? ( >=virtual/jdk-1.6 ) )"
RDEPEND="${CDEPEND}
	!gcj? ( !java6? ( >=virtual/jre-1.4 )
		java6? ( >=virtual/jre-1.6 ) )"

pkg_setup() {
	if ! use gcj ; then
		java-pkg-2_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}" || die

	# These have their own package.
	rm -f org/eclipse/jdt/core/JDTCompilerAdapter.java || die
	rm -fr org/eclipse/jdt/internal/antadapter || die

	if use gcj || ! use java6 ; then
		rm -fr org/eclipse/jdt/internal/compiler/{apt,tool}/ || die
	fi
}

src_compile() {
	local javac_opts javac java jar

	if use gcj ; then
		local gccbin="$(gcc-config -B $(ls -1r /etc/env.d/gcc/${CHOST}-* | head -1) || die)"
		local gcj="${gccbin}/gcj"
		javac="${gcj} -C -encoding ISO-8859-1"
		jar="${gccbin}/gjar"
		[[ -x ${jar} ]] || jar="${gccbin}/fastjar"
		[[ -x ${jar} ]] || die "No jar found for gcc"
		java="${gccbin}/gij"
	else
		javac_opts="$(java-pkg_javac-args) -encoding ISO-8859-1"
		javac="$(java-config -c)"
		java="$(java-config -J)"
		jar="$(java-config -j)"
	fi

	mkdir -p bootstrap || die
	cp -a org bootstrap || die
	cd "${S}/bootstrap" || die

	einfo "bootstrapping ${MY_PN} with ${javac} ..."
	${javac} ${javac_opts} $(find org/ -name '*.java') || die
	find org/ -name '*.class' -o -name '*.properties' -o -name '*.rsc' |\
		xargs ${jar} cf ${MY_PN}.jar

	cd "${S}" || die
	einfo "building ${MY_PN} with bootstrapped ${MY_PN} ..."
	${java} -classpath bootstrap/${MY_PN}.jar \
		org.eclipse.jdt.internal.compiler.batch.Main \
		${javac_opts} -nowarn org || die
	find org/ -name '*.class' -o -name '*.properties' -o -name '*.rsc' |\
		xargs ${jar} cf ${MY_PN}.jar

	if use gcj ; then
		einfo "Building native ${MY_PN} binary ..."
		${gcj} ${CFLAGS} -findirect-dispatch -Wl,-Bsymbolic -o native_${MY_PN}-${SLOT} \
			--main=org.eclipse.jdt.internal.compiler.batch.Main ${MY_PN}.jar || die
	fi
}

src_install() {
	if use gcj ; then
		dobin native_${MY_PN}-${SLOT}
		newbin "${FILESDIR}/ecj-${SLOT}" ${MY_PN}-${SLOT}

		# Don't complain when doing dojar below.
		JAVA_PKG_WANT_SOURCE=1.4
		JAVA_PKG_WANT_TARGET=1.4
	else
		java-pkg_dolauncher ${MY_PN}-${SLOT} --main \
			org.eclipse.jdt.internal.compiler.batch.Main
	fi

	java-pkg_dojar ${MY_PN}.jar
}

pkg_postinst() {
	einfo "To get the Compiler Adapter of ECJ for ANT..."
	einfo " # emerge ant-eclipse-ecj"
	echo
	einfo "To select between slots of ECJ..."
	einfo " # eselect ecj"

	eselect ecj update ecj-${SLOT}
}

pkg_postrm() {
	eselect ecj update
}
