# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.4-r1.ebuild,v 1.11 2012/07/29 18:34:32 armin76 Exp $

inherit eutils

IUSE="tk threads"

DESCRIPTION="A set of extensions to TCL"
HOMEPAGE="http://tclx.sourceforge.net"
SRC_URI="mirror://sourceforge/tclx/${PN}${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND=">=dev-lang/tcl-8.4.6
	tk? ( >=dev-lang/tk-8.4.6 )"

S=${WORKDIR}/${PN}${PV}

# tests broken, bug #279283
RESTRICT="test"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-relid.patch
	epatch ${FILESDIR}/${P}-varinit.patch
}

src_compile() {
	econf \
		$(use_enable tk) \
		$(use_enable threads) \
		--enable-shared \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
	doman doc/*.[n3]
}
