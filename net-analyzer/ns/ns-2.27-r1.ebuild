# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ns/ns-2.27-r1.ebuild,v 1.1 2004/01/28 04:04:33 robbat2 Exp $

DESCRIPTION="Network Simulator"
HOMEPAGE="http://www.isi.edu/nsnam/ns/"
SRC_URI="http://www.isi.edu/nsnam/dist/${PN}-src-${PV}.tar.gz"
LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc debug"
need_tclver="8.4.4"
valid_tclver="${need_tclver}"
mytclver=""
DEPEND_COMMON=">=dev-lang/tcl-${need_tclver}
		>=dev-lang/tk-${need_tclver}
		>=dev-tcltk/otcl-1.0.8a
		>=dev-tcltk/tclcl-1.0.13b
		net-libs/libpcap
		debug? ( =dev-lang/perl-5* >=media-gfx/xgraph-12.1 >=dev-libs/dmalloc-4.8.2 >=dev-tcltk/tcl-debug-2.0 )"
DEPEND="doc? ( app-text/tetex virtual/ghostscript dev-tex/latex2html ) ${DEPEND_COMMON}"
RDEPEND="${DEPEND_COMMON}"
S=${WORKDIR}/${P}

findtclver() {
	# input should always be in INCREASING order
	local ACCEPTVER="8.3 8.4"
	[ -n "$*" ] && ACCEPTVER="$*"
	for i in ${ACCEPTVER}; do
		use debug && einfo "Testing TCL ${i}"
		# we support being more specific
		[ "$(#i)" = "3" ] && i="${i}*"
		has_version ">=dev-lang/tcl-${i}" && mytclver=${i}
	done
	use debug && einfo "Using TCL ${mytclver}"
	if [ -z "${mytclver}" ]; then
		die "Unable to find a suitable version of TCL"
	fi
}

src_compile() {
	local myconf
	use debug && myconf="${myconf} --with-tcldebug=/usr/lib/tcldbg2.0" || myconf="${myconf} --with-tcldebug=no"
	myconf="${myconf} `use_with debug dmalloc`"
	local mytclver=""
	for i in 8.4 8.3; do
		einfo "Testing TCL ${i}"
		has_version "=dev-lang/tcl-${i}*" && mytclver=${i}
		[ "${#mytclver}" -gt 2 ] && break
	done
	einfo "Using TCL ${mytclver}"
	myconf="${myconf} --with-tcl-ver=${mytclver} --with-tk-ver=${mytclver}"

	econf \
	${myconf} \
	--mandir=/usr/share/man \
	--enable-stl \
	--enable-release || die "./configure failed"
	emake CCOPT="${CFLAGS}" || die

	cd ${S}/indep-utils/dosdbell
	emake DFLAGS="${CFLAGS}" || die
	cd ${S}/indep-utils/dosreduce
	gcc ${CFLAGS} dosreduce.c -o dosreduce
	cd ${S}/indep-utils/propagation
	g++ ${CXXFLAGS} threshold.cc -o threshold
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	make DESTDIR=${D} MANDEST=/usr/share/man install || die
	dobin nse

	dodoc BASE-VERSION COPYRIGHTS FILES HOWTO-CONTRIBUTE README VERSION
	dohtml CHANGES.html TODO.html

	cp -ra ${S}/ns-tutorial ${D}/usr/share/doc/${PF}
	cp -ra ${S}/tcl ${D}/usr/share/ns

	cd ${S}/indep-utils/dosdbell
	dobin dosdbell dosdbellasim
	newdoc README README.dosdbell
	cd ${S}/indep-utils/dosreduce
	dobin dosreduce
	newdoc README README.dosreduce
	cd ${S}/indep-utils/cmu-scen-gen
	dobin cbrgen.tcl
	newdoc README README.cbrgen
	cd ${S}/indep-utils/propagation
	dobin threshold

	if use doc; then
		einfo "Generating extra docs"
		cd ${S}/doc
		docinto doc
		emake all
		dodoc everything.dvi everything.ps.gz everything.html everything.pdf
	fi
}
