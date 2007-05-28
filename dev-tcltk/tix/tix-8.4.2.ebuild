# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tix/tix-8.4.2.ebuild,v 1.2 2007/05/28 23:44:11 matsuu Exp $

inherit eutils

MY_P="Tix${PV}"
DESCRIPTION="A widget library for Tcl/Tk. Has been ported to Python and Perl, too."
HOMEPAGE="http://tix.sourceforge.net/"
SRC_URI="mirror://sourceforge/tix/${MY_P}-src.tar.gz"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RESTRICT="test"

DEPEND=">=sys-apps/sed-4
	>=dev-lang/tk-8.4
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die

	# Bug 168897
	insinto /usr/include; doins generic/tix.h

	dodoc ChangeLog README.txt docs/*.txt
	dohtml -r index.html ABOUT.html docs/
}
