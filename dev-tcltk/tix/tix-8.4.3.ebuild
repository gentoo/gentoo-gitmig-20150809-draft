# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tix/tix-8.4.3.ebuild,v 1.11 2012/06/17 18:12:34 armin76 Exp $

EAPI="2"

inherit eutils multilib

MY_P="Tix${PV}"
DESCRIPTION="A widget library for Tcl/Tk"
HOMEPAGE="http://tix.sourceforge.net/"
SRC_URI="mirror://sourceforge/tix/${MY_P}-src.tar.gz"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"

RESTRICT="test"

DEPEND="
	dev-lang/tk
	sys-apps/sed
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die

	# Bug 168897
	insinto /usr/include; doins generic/tix.h || die
	# Bug 201138
	dosym ${MY_P}/lib${MY_P}.so /usr/$(get_libdir)/lib${MY_P}.so || die

	dodoc ChangeLog README.txt docs/*.txt || die
	dohtml -r index.html ABOUT.html docs/ || die
}
