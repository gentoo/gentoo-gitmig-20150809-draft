# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ns/ns-2.28.ebuild,v 1.5 2006/03/29 13:18:32 exg Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Network Simulator"
HOMEPAGE="http://www.isi.edu/nsnam/ns/"
SRC_URI="http://www.isi.edu/nsnam/dist/${PN}-src-${PV}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE="doc debug"

RDEPEND=">=dev-lang/tcl-8.4.4
		>=dev-lang/tk-8.4.4
		>=dev-tcltk/otcl-1.0.8a
		>=dev-tcltk/tclcl-1.0.13b
		virtual/libpcap
		debug? ( 	=dev-lang/perl-5*
					>=sci-visualization/xgraph-12.1
					>=dev-libs/dmalloc-4.8.2
					>=dev-tcltk/tcl-debug-2.0 )"
DEPEND="${RDEPEND}
		doc? ( 	virtual/tetex
				virtual/ghostscript
				dev-tex/latex2html )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-gcc41.patch
}

src_compile() {
	local myconf
	local mytclver=""
	local i

	tc-export CC CXX

	use debug \
		&& myconf="${myconf} --with-tcldebug=/usr/lib/tcldbg2.0" \
		|| myconf="${myconf} --with-tcldebug=no"
	myconf="${myconf} $(use_with debug dmalloc)"

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
	${CC} ${CFLAGS} dosreduce.c -o dosreduce
	cd ${S}/indep-utils/propagation
	${CXX} ${CXXFLAGS} threshold.cc -o threshold

	if useq doc; then
		einfo "Generating extra docs"
		cd ${S}/doc
		emake all
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
	insinto /usr/share/doc/${PF}
	doins -r ns-tutorial
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

	if use doc; then
		cd ${S}/doc
		docinto doc
		dodoc everything.dvi everything.ps.gz everything.html everything.pdf
	fi
}
