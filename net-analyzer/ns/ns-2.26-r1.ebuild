# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ns/ns-2.26-r1.ebuild,v 1.1 2004/01/20 23:14:40 robbat2 Exp $

DESCRIPTION="Network Simulator"
HOMEPAGE="http://www.isi.edu/nsnam/ns/"
SRC_URI="http://www.isi.edu/nsnam/dist/${PN}-src-${PV}.tar.gz"
LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc debug"
DEPEND_COMMON=">=dev-lang/tcl-8.3.2
		>=dev-lang/tk-8.3.2
		>=dev-tcltk/otcl-1.0.8a
		>=dev-tcltk/tclcl-1.0.13b
		net-libs/libpcap
		debug? ( =dev-lang/perl-5* >=media-gfx/xgraph-12.1 >=dev-libs/dmalloc-4.8.2 >=dev-tcltk/tcl-debug-2.0 )"
DEPEND="doc? ( app-text/tetex app-text/ghostscript dev-tex/latex2html ) ${DEPEND_COMMON}"
# for later
#RDEPEND=">=net-analyzer/nam-1.9 ${DEPEND_COMMON}"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	grep -ri 'tcl\.result[[:space:]]*()' * -l | \
	xargs -r -n1 sed -e 's|tcl\.result[[:space:]]*()|(char*)tcl.result()|' -i
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
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	make DESTDIR=${D} MANDEST=/usr/share/man install || die
	dobin nse

	dodoc BASE-VERSION COPYRIGHTS FILES HOWTO-CONTRIBUTE README VERSION
	dohtml CHANGES.html TODO.html

	if use doc; then
		einfo "Generating extra docs"
		cd doc
		docinto doc
		emake all
		dodoc everything.dvi everything.ps.gz everything.html everything.pdf
	fi

	cp -ra ${S}/ns-tutorial ${D}/usr/share/doc/${PF}
	cp -ra ${S}/tcl ${D}/usr/share/ns
}
