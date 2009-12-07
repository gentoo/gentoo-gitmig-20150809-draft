# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/clang/clang-2.6-r1.ebuild,v 1.4 2009/12/07 23:28:32 voyageur Exp $

EAPI=2
inherit eutils python

DESCRIPTION="C language family frontend for LLVM"
HOMEPAGE="http://clang.llvm.org/"
# Fetching LLVM as well: see http://llvm.org/bugs/show_bug.cgi?id=4840
SRC_URI="http://llvm.org/releases/${PV}/llvm-${PV}.tar.gz
	http://llvm.org/releases/${PV}/${P}.tar.gz"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +static-analyzer test"

# Note: for LTO support, clang will depend on binutils with gold plugins, and LLVM built after that - http://llvm.org/docs/GoldPlugin.html
DEPEND="static-analyzer? ( dev-lang/perl )
	test? ( dev-util/dejagnu )"
RDEPEND="~sys-devel/llvm-${PV}"

S="${WORKDIR}/llvm-2.6"

src_prepare() {
	mv "${WORKDIR}"/clang-2.6 "${S}"/tools/clang || die "clang source directory not found"

	# Same as llvm doc patches
	epatch "${FILESDIR}"/${PN}-2.6-fixdoc.patch

	# multilib-strict
	sed -e "/PROJ_headers/s#lib/clang/1.0#$(get_libdir)/clang/1.0#" \
		-i tools/clang/lib/Headers/Makefile \
		|| die "clang Makefile failed"
	# fix the static analyzer for in-tree install
	sed -e 's/import ScanView/from clang \0/'  \
		-i tools/clang/tools/scan-view/scan-view \
		|| die "scan-view sed failed"
	sed -e "/scanview.css\|sorttable.js/s#\$RealBin#/usr/share/${PN}#" \
		-i tools/clang/utils/scan-build \
		|| die "scan-build sed failed"
	# Broken test in 2.6, http://llvm.org/bugs/show_bug.cgi?id=5111
	rm tools/clang/test/Analysis/retain-release.m

	# From llvm src_prepare
	einfo "Fixing install dirs"
	sed -e 's,^PROJ_docsdir.*,PROJ_docsdir := $(DESTDIR)$(PROJ_prefix)/share/doc/'${PF}, \
		-e 's,^PROJ_etcdir.*,PROJ_etcdir := $(DESTDIR)/etc/llvm,' \
		-e 's,^PROJ_libdir.*,PROJ_libdir := $(DESTDIR)/usr/'$(get_libdir), \
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

	econf ${CONF_FLAGS} || die "econf failed"
}

src_compile() {
	emake VERBOSE=1 KEEP_SYMBOLS=1  clang-only || die "emake failed"
}

src_test() {
	cd "${S}"/tools/clang || die "cd clang failed"

	vecho ">>> Test phase [test]: ${CATEGORY}/${PF}"
	if ! emake -j1 VERBOSE=1 test; then
		hasq test $FEATURES && die "Make test failed. See above for details."
		hasq test $FEATURES || eerror "Make test failed. See above for details."
	fi
}

src_install() {
	cd "${S}"/tools/clang || die "cd clang failed"
	emake KEEP_SYMBOLS=1 DESTDIR="${D}" install || die "install failed"

	if use static-analyzer ; then
		dobin utils/ccc-analyzer
		dobin utils/scan-build

		insinto /usr/share/${PN}
		doins utils/scanview.css
		doins utils/sorttable.js

		cd tools/scan-view || die "cd scan-view failed"
		dobin scan-view
		python_version
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/clang
		doins Reporter.py Resources ScanView.py startfile.py
		touch "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/clang/__init__.py
	fi
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/clang
}

pkg_postrm() {
	python_mod_cleanup
}
