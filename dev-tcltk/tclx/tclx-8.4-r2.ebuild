# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.4-r2.ebuild,v 1.1 2010/04/02 09:22:48 jlec Exp $

EAPI="3"

inherit eutils

DESCRIPTION="A set of extensions to TCL"
HOMEPAGE="http://tclx.sourceforge.net"
SRC_URI="mirror://sourceforge/tclx/${PN}${PV}.tar.bz2"

LICENSE="BSD"
IUSE="tk threads"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"

DEPEND=">=dev-lang/tcl-8.4.6
	tk? ( >=dev-lang/tk-8.4.6 )"

S="${WORKDIR}"/${PN}${PV}

# tests broken, bug #279283
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${P}-relid.patch
	epatch "${FILESDIR}"/${P}-varinit.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_configure() {
	econf \
		$(use_enable tk) \
		$(use_enable threads) \
		--enable-shared \
		--with-tcl="${EPREFIX}/usr/lib/" \
		|| die "econf failed"

	# adjust install_name on darwin
	if [[ ${CHOST} == *-darwin* ]]; then
		sed -i \
			-e 's:^\(SHLIB_LD\W.*\)$:\1 -install_name ${pkglibdir}/$@:' \
				"${S}"/Makefile || die 'sed failed'
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
	doman doc/*.[n3]
}
