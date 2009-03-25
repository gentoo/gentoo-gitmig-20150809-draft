# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbxml/dbxml-2.4.16.1.ebuild,v 1.3 2009/03/25 11:40:54 loki_val Exp $

EAPI="1"

inherit flag-o-matic perl-app python eutils versionator multilib java-pkg-opt-2

MY_PV="$(get_version_component_range 1-3)"
MY_P="${PN}-${MY_PV}"
PATCH_V="$(get_version_component_range 4)"
PATCH_V="${PATCH_V:-0}"

DESCRIPTION="BerkeleyDB XML, a native XML database from the BerkeleyDB team"
HOMEPAGE="http://www.oracle.com/database/berkeley-db/xml/index.html"
SRC_URI="http://download-east.oracle.com/berkeley-db/${MY_P}.tar.gz
	http://download-west.oracle.com/berkeley-db/${MY_P}.tar.gz
	http://download-uk.oracle.com/berkeley-db/${MY_P}.tar.gz"
LICENSE="OracleDB Apache-1.1 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples java perl python tcl"

RDEPEND="sys-libs/db:4.6
	=dev-libs/xerces-c-2.8*
	>=dev-libs/xqilla-2.1.2
	perl? ( dev-lang/perl )
	python? (
		dev-lang/python:2.5
		>=dev-python/bsddb3-4.5.0 )
	tcl? ( dev-lang/tcl )
	java? ( >=virtual/jre-1.5 )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.5 )"

get_patches() {
	local patches=""
	local patch_v=1
	while [ ${patch_v} -le ${PATCH_V} ] ; do
		patches="${patches} patch.${MY_PV}.${patch_v}"
		let "patch_v = ${patch_v} + 1"
	done
	echo ${patches}
}

for patch in $(get_patches) ; do
	SRC_URI="${SRC_URI}
		http://www.oracle.com/technology/products/berkeley-db/xml/update/${MY_PV}/${patch}"
done

S="${WORKDIR}/${MY_P}/dbxml"

DB_VER="4.6"

pkg_setup() {
	if built_with_use sys-libs/db:${DB_VER} nocxx ; then
		eerror "sys-libs/db:${DB_VER} must be built without nocxx USE-flag"
		die "sys-libs/db:${DB_VER} must be built without nocxx USE-flag"
	fi
	if use java && ! built_with_use sys-libs/db:${DB_VER} java ; then
		eerror "sys-libs/db:${DB_VER} must be built with java USE-flag"
		die "sys-libs/db:${DB_VER} must be built with java USE-flag"
	fi
	java-pkg-opt-2_pkg_setup
}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd "${S}"

	for patch in $(get_patches) ; do
		edos2unix "${DISTDIR}/${patch}"
		epatch "${DISTDIR}/${patch}"
	done

	epatch "${FILESDIR}/2.4.13-as_needed.patch"

	# sys-libs/db is slotted on Gentoo
	sed -i \
		-e "s:db_version=.*:db_version=4.6:" \
		dist/configure || die "sed failed"
	if use java ; then
		sed -i \
			-e "s|\$with_berkeleydb/lib/db.jar|$(java-pkg_getjars db-${DB_VER})|" \
			dist/configure || die "sed failed"
	fi

	# * Fix libraries to link
	# * Strip "../../build_unix/.libs" from LIBPATH or it'll
	#   show up in the RPATH entry
	sed -i \
		-e "s|dbxml-2|dbxml-$(get_version_component_range 1-2)|" \
		-e "s|db_cxx-4|db_cxx-${DB_VER}|" \
		-e 's|"../../build_unix/.libs",||' \
		src/python/setup.py.in || die "sed failed"

	sed -i \
		-e "s|dbxml-2|dbxml-$(get_version_component_range 1-2)|" \
		-e "s|db_cxx-4|db_cxx-${DB_VER}|" \
		-e "s|@DB_DIR@/lib|/usr/$(get_libdir)|" \
		-e "s|@DB_DIR@/include|/usr/include/db${DB_VER}|" \
		-e "s|@XERCES_DIR@/lib|/usr/$(get_libdir)|" \
		-e "s|@XQILLA_DIR@/lib|/usr/$(get_libdir)|" \
		src/perl/config.in || die "sed failed"
}

src_compile() {
	cd "${S}/build_unix"

	#Needed despite db_version stuff above
	append-flags -I/usr/include/db4.6

	local myconf=""

	# use_enable doesn't work here due to a different syntax
	use java && myconf="${myconf} --enable-java"
	use tcl && myconf="${myconf} --enable-tcl --with-tcl=/usr/$(get_libdir)"

	ECONF_SOURCE=../dist
	export ac_cv_prog_path_strip="missing_strip"
	JAVAPREFIX="${JAVA_HOME}" \
		econf \
			--with-berkeleydb=/usr \
			--with-xqilla=/usr \
			--with-xerces=/usr \
			${myconf}|| die "econf failed"
	ECONF_SOURCE=
	emake -j1 || die "emake failed"

	if use python ; then
		einfo "Compiling python extension"
		cd "${S}/src/python"
		append-ldflags "-L../../build_unix/.libs"
		python_version
		"${python}" setup.py build || die "python build failed"
	fi

	if use perl ; then
		cd "${S}/src/perl"
		perl-app_src_prep
		perl-app_src_compile
	fi
}

src_install() {
	cd "${S}/build_unix"

	# somewhat broken build system
	einstall || die "einstall failed"

	use doc && dohtml -A pdf -r "${D}"/usr/docs/*
	rm -rf "${D}/usr/docs"

	if use java ; then
		java-pkg_dojar "${D}/usr/$(get_libdir)/dbxml.jar"
		rm "${D}/usr/$(get_libdir)/dbxml.jar"
	fi

	if use python ; then
		cd "${S}/src/python"
		python_version
		"${python}" setup.py install --root="${D}" --no-compile || die "python install failed"
	fi

	if use perl ; then
		cd "${S}/src/perl"
		emake DESTDIR="${D}" install || die "emake install perl module failed"
	fi

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/examples"
	fi

}

pkg_preinst() {
	perl-module_pkg_preinst
	java-pkg-opt-2_pkg_preinst
}

pkg_postinst() {
	if use python ; then
		python_version
		python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages
	fi
}

pkg_postrm() {
	if use python ; then
		python_version
		python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages
	fi
}
