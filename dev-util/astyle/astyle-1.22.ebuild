# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/astyle/astyle-1.22.ebuild,v 1.1 2008/05/12 06:03:36 nerdboy Exp $

inherit eutils java-pkg-opt-2

DESCRIPTION="Artistic Style is a reindenter and reformatter of C++, C and Java source code"
HOMEPAGE="http://astyle.sourceforge.net/"
SRC_URI="mirror://sourceforge/astyle/astyle_${PV}_linux.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug java libs"

RDEPEND="java? ( >=virtual/jre-1.5 )"

DEPEND="java? ( >=virtual/jre-1.5 )"

S=${WORKDIR}/${PN}

pkg_setup() {
	use java && java-pkg-2_pkg_setup

	if use x86; then
	    jvmarch=i386
	else
	    jvmarch=${ARCH}
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-strip.patch
	# Add basic soname to make QA happy...
	sed -i -e "s:-shared:-shared -Wl,-soname,\$@ :g" buildgcc/Makefile
	use java && setup-jvm-opts
}

src_compile() {
	cd buildgcc

	local build_targets="all"
	use java && build_targets="${build_targets} javaall"

	emake ${build_targets} || die "build failed"
}

src_install() {
	if use debug ; then
	    newbin bin/astyled astyle || die "install debug bin failed"
	    newlib.a bin/libastyled.a libastyle.a  \
		|| die "install debug static lib failed"
	    if use libs ; then
		# shared lib got a soname patch
		newlib.so bin/libastyled.so libastyle.so \
		    || die "install debug shared lib failed"
		if use java ; then
		    local j_dir="/usr/$(get_libdir)"
		    dolib.so bin/libastylejd.so \
			|| die "install debug shared java lib failed"
		    java-pkg_regso "${D}${j_dir}/libastylejd.so"
		fi
	    fi
	else
	    if use libs ; then
		dolib.so bin/libastyle.so || die "install shared lib failed"
		if use java ; then
		    local j_dir="/usr/$(get_libdir)"
		    dolib.so bin/libastylej.so \
			|| die "install shared java lib failed"
		    java-pkg_regso "${D}${j_dir}/libastylej.so"
		fi
	    fi
	    dobin bin/astyle || die "install bin failed"
	    dolib.a bin/libastyle.a || die "install static lib failed"
	fi
	dohtml doc/*.html
}

setup-jvm-opts() {
	# Figure out correct boot classpath
	# stolen from eclipse-sdk ebuild
	local bp="$(java-config --jdk-home)/jre/lib"
	local bootclasspath=$(java-config --runtime)
	if java-config --java-version | grep -q IBM ; then
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

