# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rjava/rjava-0.5.1.ebuild,v 1.1 2007/10/01 04:42:43 nerdboy Exp $

JAVA_PKG_IUSE="examples"

inherit eutils java-pkg-2 versionator

MY_PN=rJava
MY_PV=$(replace_version_separator 2 '-' )
MY_P=${MY_PN}_${MY_PV}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="The current rJava interface (also includes JRI)"
HOMEPAGE="http://www.rforge.net/rJava/"
SRC_URI="http://www.rforge.net/${MY_PN}/snapshot/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

COMMON_DEP=">=dev-lang/R-2.5.0"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

pkg_setup() {
	java-pkg-2_pkg_setup

	if use x86; then
	    jvmarch=i386
	else
	    jvmarch=${ARCH}
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	setup-jvm-opts
}

src_compile() {
	export R_HOME="/usr/$(get_libdir)/R"

	# use R's check command to test package (really needs to come before
	# the src_compile section)
	if has test ${FEATURES}; then
	    cd ${WORKDIR}
	    R CMD check ${MY_PN}
	fi

	cd "${S}"
	local my_conf="--enable-jri"
	econf ${my_conf} || die "econf failed"
	cd src/
	make -f Makevars all || die "make failed"
}

src_install() {
	export R_LIBS_SITE="${R_HOME}/site-library"
	keepdir ${R_LIBS_SITE}
	cd ${WORKDIR}
	R CMD INSTALL --no-configure -l "${D}${R_LIBS_SITE}" ${MY_PN} \
	    || die "install failed"
	cd ${S}

	local jri_dir="/usr/$(get_libdir)/jri"
	java-pkg_jarinto ${jri_dir}
	java-pkg_dojar inst/jri/JRI.jar

	insinto ${jri_dir}
	insopts -m0755
	doins inst/jri/libjri.so
	java-pkg_regso "${D}${jri_dir}/libjri.so"

	echo "R_HOME=${R_HOME}">25rjava
	echo "LD_LIBRARY_PATH=${R_HOME}/lib:${JAVA_LIB_DIR}">>25rjava
	echo "R_INCLUDE_DIR=${R_HOME}/include">>25rjava
	echo "R_SHARE_DIR=${R_HOME}/share">>25rjava
	echo "R_DOC_DIR=${R_HOME}/doc">>25rjava

	insopts -m0644
	doenvd 25rjava

	dodoc NEWS
	newdoc jri/README README.jri
	use examples && java-pkg_doexamples jri/examples
}

setup-jvm-opts() {
	# Figure out correct boot classpath
	# stolen from eclipse-sdk ebuild
	local bp="$(java-config --jdk-home)/jre/lib"
	local bootclasspath=$(java-config --runtime)
	if [[ ! -z "`java-config --java-version | grep IBM`" ]] ; then
		# IBM JDK
		JAVA_LIB_DIR="$(java-config --jdk-home)/jre/bin"
	else
		# Sun derived JDKs (Blackdown, Sun)
		JAVA_LIB_DIR="$(java-config --jdk-home)/jre/lib/${jvmarch}"
	fi

	einfo "Using bootclasspath ${bootclasspath}"
	einfo "Using JVM library path ${JAVA_LIB_DIR}"

	if [[ ! -f ${JAVA_LIB_DIR}/libawt.so ]] ; then
		die "Could not find libawt.so native library"
	fi

	export AWT_LIB_PATH=${JAVA_LIB_DIR}
}

pkg_postinst () {
	elog
	elog "The rJava package also includes the JRI tools, so rJava now"
	elog "provides both sides of the overall interface.  The rJava piece"
	elog "is installed as an R package, while JRI is composed of the .jar"
	elog "file and libjri.so, which are registered with the Java packaging"
	elog "tools."
	elog
	elog "Some documentation on JRI can be found in the usual place,"
	elog "along with the internal R docs in various formats."
	elog
	elog "Note: JRI is also installed under the R site-library dir."
	elog "(see the 'run' script installed with the R package for one"
	elog "way to run the JRI examples, however, the environment setup"
	elog "should be taken care of by the java eclass functions and the"
	elog "env.d file installed by the ebuild)."
	elog
	elog "http://www.rforge.net/rJava/index.html"
	elog "The above URL is the correct home page for the current rJava release."
	elog "The sourceforge page called RJava is old and no longer maintained."
	elog

	ewarn "Please perform"
	ewarn "  env-update"
	ewarn "  source /etc/profile"
	ewarn "prior to using JRI."
	elog
}
