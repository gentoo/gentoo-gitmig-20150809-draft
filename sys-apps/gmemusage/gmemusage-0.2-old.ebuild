# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gmemusage/gmemusage-0.2-old.ebuild,v 1.1.1.1 2005/11/30 09:56:01 chriswhite Exp $

#  I need to get md5s from the author.
#	I have personally audited this code for malicious crap and will 
#	state that there is nothing obvious.  RiverRat        (small program)

DESCRIPTION="gmemusage is based on the very useful SGI IRIX utility of the same name."
HOMEPAGE="http://www.reptilelabour.com/software/gmemusage/index.htm"
SRC_URI="http://www.reptilelabour.com/software/files/${PN}/${P}-082599.tgz"

inherit eutils

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}"

RDEPEND="virtual/x11
	virtual/opengl"

IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch || die "patch failed"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin gmemusage
	dodoc README COPYING
}
