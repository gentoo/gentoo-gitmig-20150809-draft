# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.72.ebuild,v 1.2 2004/02/05 16:24:19 tester Exp $

DESCRIPTION="GUI for iPod using GTK2"

HOMEPAGE="http://gtkpod.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
mirror://sourceforge/${PN}/mp4file.c"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="mpeg4"

DEPEND=">=x11-libs/gtk+-2.0.0
		>=x11-libs/pango-1.2.1
		media-libs/libid3tag
		mpeg4? ( media-video/mpeg4ip )"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gtkpod-0.72-c89_fix.patch
	cp ${DISTDIR}/mp4file.c ${S}/src
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README
}
