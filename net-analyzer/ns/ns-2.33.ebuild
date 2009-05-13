# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ns/ns-2.33.ebuild,v 1.1 2009/05/13 15:06:27 fmccor Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Network Simulator"
HOMEPAGE="http://www.isi.edu/nsnam/ns/"
SRC_URI="http://downloads.sourceforge.net/nsnam/${PN}-${PV}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE="doc debug"

RDEPEND=">=dev-lang/tcl-8.4.5
		>=dev-lang/tk-8.4.5
		>=dev-tcltk/otcl-1.11
		>=dev-tcltk/tclcl-1.17
		virtual/libpcap
		debug? (	=dev-lang/perl-5*
					>=sci-visualization/xgraph-12.1
					>=dev-libs/dmalloc-4.8.2
					>=dev-tcltk/tcl-debug-2.0 )"
DEPEND="${RDEPEND}
		doc? (	virtual/latex-base
				virtual/ghostscript
				dev-tex/latex2html )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed '/$(CC)/s!-g!$(CFLAGS)!g' "${S}/indep-utils/model-gen/Makefile"
}

src_compile() {
	local myconf
	local mytclver=""
	local i

	tc-export CC CXX

	# correctness is more important than speed
	replace-flags -Os -O2
	replace-flags -O3 -O2

	use debug \
		&& myconf="${myconf} --with-tcldebug=/usr/lib/tcldbg2.0" \
		|| myconf="${myconf} --with-tcldebug=no"
	myconf="${myconf} $(use_with debug dmalloc)"

	for i in 8.4 ; do
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

	cd "${S}/indep-utils/dosdbell"
	emake DFLAGS="${CFLAGS}" || die
	cd "${S}/indep-utils/dosreduce"
	${CC} ${CFLAGS} dosreduce.c -o dosreduce
	cd "${S}/indep-utils/propagation"
	${CXX} ${CXXFLAGS} threshold.cc -o threshold
	cd "${S}/indep-utils/model-gen"
	emake CFLAGS="${CFLAGS}" || die

	if useq doc; then
		einfo "Generating extra docs"
		cd "${S}/doc"
		yes '' | emake all
	fi
}

src_install() {
	dodir /usr/bin /usr/share/man/man1 /usr/share/doc/${PF} /usr/share/ns
	make DESTDIR="${D}" MANDEST=/usr/share/man install \
		|| die "make install failed"
	dobin nse

	dodoc BASE-VERSION COPYRIGHTS FILES HOWTO-CONTRIBUTE README VERSION
	dohtml CHANGES.html TODO.html

	cd "${S}"
	insinto /usr/share/ns
	doins -r tcl

	cd "${S}/indep-utils/dosdbell"
	dobin dosdbell dosdbellasim
	newdoc README README.dosdbell
	cd "${S}/indep-utils/dosreduce"
	dobin dosreduce
	newdoc README README.dosreduce
	cd "${S}/indep-utils/cmu-scen-gen"
	dobin cbrgen.tcl
	newdoc README README.cbrgen
	cd "${S}/indep-utils/propagation"
	dobin threshold
	cd "${S}/indep-utils/model-gen"
	dobin http_connect http_active

	if use doc; then
		cd "${S}/doc"
		docinto doc
		dodoc everything.dvi everything.ps.gz everything.html everything.pdf
		docinto model-gen
		cd "${S}/indep-utils/model-gen"
		dodoc *
	fi
}

src_test() {
	einfo "Warning, these tests will take upwards of 45 minutes."
	einfo "Additionally, as shipped, a number of tests may fail."
	einfo "We log to 'validate.run', which you should compare against"
	einfo "the shipped 'validate.out' to evaluate success."
	einfo "At the time of assembling this ebuild, these test suites failed:"
	einfo "srm smac-multihop hier-routing algo-routing mcast vc"
	einfo "session mixmode webcache mcache plm wireless-tdma"
	./validate 2>&1 | tee "${S}/validate.run"
}
