# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-2.1.1.ebuild,v 1.2 2009/08/08 22:09:56 ssuominen Exp $

ARTS_REQUIRED="never"

inherit eutils kde

DESCRIPTION="A Graphical Debugger Interface to gdb."
HOMEPAGE="http://www.kdbg.org/"
SRC_URI="mirror://sourceforge/kdbg/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-devel/gdb-5.0"

need-kde 3.5

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}
