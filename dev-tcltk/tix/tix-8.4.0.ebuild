# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tix/tix-8.4.0.ebuild,v 1.1 2006/09/24 06:27:36 matsuu Exp $

inherit eutils

DESCRIPTION="A widget library for Tcl/Tk. Has been ported to Python and Perl, too."
HOMEPAGE="http://tix.sourceforge.net/"
SRC_URI="mirror://sourceforge/tix/${P}.tar.gz"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RESTRICT="test"

DEPEND=">=sys-apps/portage-2.0.47-r10
		>=sys-apps/sed-4
		dev-lang/tk"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/relid'/relid/" configure tclconfig/tcl.m4 || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc ChangeLog README.txt
}
