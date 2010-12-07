# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcldom/tcldom-3.1.ebuild,v 1.6 2010/12/07 17:18:55 jlec Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Document Object Model For Tcl"
HOMEPAGE="http://tclxml.sourceforge.net/tcldom.html"
SRC_URI="mirror://sourceforge/tclxml/${P}.tar.gz"

IUSE="expat xml threads"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-tcltk/tcllib-1.2
	~dev-tcltk/tclxml-3.1
	expat? ( dev-libs/expat )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}"/${PV}-ldflags.patch

	cd "${S}/library"
	sed -e "s/@VERSION@/${PV}/" \
		-e "s/@Tcldom_LIB_FILE@@/UNSPECIFIED/" \
		< pkgIndex.tcl.in > pkgIndex.tcl

	# bug 131148
	sed -i -e "s/relid'/relid/" "${S}"/*/{configure,tcl.m4} || die
}

src_compile() {
	local myconf="--with-tcl=/usr/$(get_libdir)"

	tc-export CC

	export LDFLAGS_OPTIMIZE="${LDFLAGS}"

	use threads && myconf="${myconf} --enable-threads"

	if use xml ; then
		cd "${S}/src-libxml2"
		econf ${myconf} --with-libxml2-lib=/usr/$(get_libdir)
		emake || die
	fi
	if use expat ; then
		cd "${S}/src"
		econf ${myconf}
		emake || die
	fi
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}${PV}
	doins library/*.tcl || die

	if use xml ; then
		cd "${S}/src-libxml2"
		emake DESTDIR="${D}" install || die
	fi
	if use expat ; then
		cd "${S}/src"
		emake DESTDIR="${D}" install || die
	fi

	cd "${S}"
	dodoc ChangeLog README RELNOTES || die
	docinto examples; dodoc examples/* || die
	dohtml docs/*.html || die
}
