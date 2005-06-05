# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/include/include-0.3.2.ebuild,v 1.11 2005/06/05 12:21:17 hansmi Exp $

DESCRIPTION="This is a collection of the useful independent include files for C/Assembler developers."
HOMEPAGE="http://openwince.sourceforge.net/include/"
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND="sys-apps/grep
	sys-apps/gawk"
RDEPEND=""

src_install() {
	emake DESTDIR=${D} install
}
