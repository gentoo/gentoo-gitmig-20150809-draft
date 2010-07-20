# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/clang/clang-2.7-r1.ebuild,v 1.1 2010/07/20 09:35:43 voyageur Exp $

EAPI=2

RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit eutils multilib python

DESCRIPTION="C language family frontend for LLVM"
HOMEPAGE="http://clang.llvm.org/"
# Fetching LLVM as well: see http://llvm.org/bugs/show_bug.cgi?id=4840
SRC_URI="http://llvm.org/releases/${PV}/llvm-${PV}.tgz
	http://llvm.org/releases/${PV}/${P}.tgz"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +static-analyzer test"

# Note: for LTO support, clang will depend on binutils with gold plugins, and LLVM built after that - http://llvm.org/docs/GoldPlugin.html
DEPEND="static-analyzer? ( dev-lang/perl )
	test? ( dev-util/dejagnu )"
RDEPEND="~sys-devel/llvm-${PV}"

S="${WORKDIR}/llvm-2.7"

src_prepare() {
	mv "${WORKDIR}"/clang-2.7 "${S}"/tools/clang || die "clang source directory not found"

	# Same as llvm doc patches
	epatch "${FILESDIR}"/${PN}-2.7-fixdoc.patch

	# multilib-strict
	sed -e "/PROJ_headers/s#lib/clang#$(get_libdir)/clang#" \
		-i tools/clang/lib/Headers/Makefile \
		|| die "clang Makefile failed"
	# fix the static analyzer for in-tree install
	sed -e 's/import ScanView/from clang \0/'  \
		-i tools/clang/tools/scan-view/scan-view \
		|| die "scan-view sed failed"
	sed -e "/scanview.css\|sorttable.js/s#\$RealBin#/usr/share/${PN}#" \
		-i tools/clang/tools/scan-build/scan-build \
		|| die "scan-build sed failed"
	# Specify python version
	python_convert_shebangs 2 tools/clang/tools/scan-view/scan-view

	# From llvm src_prepare
	einfo "Fixing install dirs"
	sed -e 's,^PROJ_docsdir.*,PROJ_docsdir := $(PROJ_prefix)/share/doc/'${PF}, \
		-e 's,^PROJ_etcdir.*,PROJ_etcdir := /etc/llvm,' \
		-e 's,^PROJ_libdir.*,PROJ_libdir := $(PROJ_prefix)/'$(get_libdir), \
		-i Makefile.config.in || die "Makefile.config sed failed"

	einfo "Fixing rpath"
	sed -e 's/\$(RPATH) -Wl,\$(\(ToolDir\|LibDir\))//g' -i Makefile.rules \
		|| die "rpath sed failed"
}

src_configure() {
	local CONF_FLAGS=""

	if use debug; then
		CONF_FLAGS="${CONF_FLAGS} --disable-optimized"
		einfo "Note: Compiling LLVM in debug mode will create huge and slow binaries"
		# ...and you probably shouldn't use tmpfs, unless it can hold 900MB
	else
		CONF_FLAGS="${CONF_FLAGS} \
			--enable-optimized \
			--disable-assertions \
			--disable-expensive-checks"
	fi

	if use amd64; then
		CONF_FLAGS="${CONF_FLAGS} --enable-pic"
	fi

	# Skip llvm-gcc parts even if installed
	CONF_FLAGS="${CONF_FLAGS} --with-llvmgccdir=/dev/null"

	# Try to get current C++ headers path
	CONF_FLAGS="${CONF_FLAGS} --with-cxx-include-root=$(gcc-config -X| cut -d: -f1)/include/g++-v4"
	CONF_FLAGS="${CONF_FLAGS} --with-cxx-include-arch=$CHOST"
	if has_multilib_profile; then
		CONF_FLAGS="${CONF_FLAGS} --with-cxx-include-32bit-dir=32"
	fi
	econf ${CONF_FLAGS} || die "econf failed"
}

src_compile() {
	emake VERBOSE=1 KEEP_SYMBOLS=1 REQUIRES_RTTI=1 clang-only || die "emake failed"
}

src_test() {
	cd "${S}"/test || die "cd failed"
	emake site.exp || die "updating llvm site.exp failed"

	cd "${S}"/tools/clang || die "cd clang failed"

	echo ">>> Test phase [test]: ${CATEGORY}/${PF}"
	if ! emake -j1 VERBOSE=1 test; then
		hasq test $FEATURES && die "Make test failed. See above for details."
		hasq test $FEATURES || eerror "Make test failed. See above for details."
	fi
}

src_install() {
	cd "${S}"/tools/clang || die "cd clang failed"
	emake KEEP_SYMBOLS=1 DESTDIR="${D}" install || die "install failed"

	if use static-analyzer ; then
		dobin tools/scan-build/ccc-analyzer
		dosym ccc-analyzer /usr/bin/c++-analyzer
		dobin tools/scan-build/scan-build

		insinto /usr/share/${PN}
		doins tools/scan-build/scanview.css
		doins tools/scan-build/sorttable.js

		cd tools/scan-view || die "cd scan-view failed"
		dobin scan-view
		install-scan-view() {
			insinto "$(python_get_sitedir)"/clang
			doins Reporter.py Resources ScanView.py startfile.py
			touch "${D}"/"$(python_get_sitedir)"/clang/__init__.py
		}
		python_execute_function install-scan-view
	fi
}

pkg_postinst() {
	python_mod_optimize clang
	elog "C++ headers search path is hardcoded to the active gcc profile one"
	elog "If you change the active gcc profile, or update gcc to a new version,"
	elog "you will have to remerge this package to update the search path"
}

pkg_postrm() {
	python_mod_cleanup clang
}
