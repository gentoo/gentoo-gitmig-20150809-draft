# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ns/ns-2.27-r1.ebuild,v 1.7 2005/01/29 05:12:51 dragonheart Exp $

inherit eutils

DESCRIPTION="Network Simulator"
HOMEPAGE="http://www.isi.edu/nsnam/ns/"
SRC_URI="http://www.isi.edu/nsnam/dist/${PN}-src-${PV}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="doc debug"

DEPEND_COMMON=">=dev-lang/tcl-8.4.4
		>=dev-lang/tk-8.4.4
		>=dev-tcltk/otcl-1.0.8a
		>=dev-tcltk/tclcl-1.0.13b
		virtual/libpcap
		debug? ( =dev-lang/perl-5* >=media-gfx/xgraph-12.1 >=dev-libs/dmalloc-4.8.2 >=dev-tcltk/tcl-debug-2.0 )"
DEPEND="doc? ( virtual/tetex virtual/ghostscript dev-tex/latex2html ) ${DEPEND_COMMON}"
RDEPEND="${DEPEND_COMMON}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	local myconf
	local mytclver=""
	local i

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
	gcc ${CFLAGS} dosreduce.c -o dosreduce
	cd ${S}/indep-utils/propagation
	g++ ${CXXFLAGS} threshold.cc -o threshold
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make DESTDIR="${D}" MANDEST=/usr/share/man install \
		|| die "make install failed"
	dobin nse

	dodoc BASE-VERSION COPYRIGHTS FILES HOWTO-CONTRIBUTE README VERSION
	dohtml CHANGES.html TODO.html

	cp -ra "${S}/ns-tutorial" "${D}/usr/share/doc/${PF}"
	cp -ra "${S}/tcl" "${D}/usr/share/ns"

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
		einfo "Generating extra docs"
		cd ${S}/doc
		docinto doc
		emake all
		dodoc everything.dvi everything.ps.gz everything.html everything.pdf
	fi
}
