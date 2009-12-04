# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vncsnapshot/vncsnapshot-1.2a.ebuild,v 1.8 2009/12/04 21:51:12 flameeyes Exp $

inherit eutils

LICENSE="GPL-2"
DESCRIPTION="A command-line tool for taking JPEG snapshots of VNC servers"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"
HOMEPAGE="http://vncsnapshot.sourceforge.net/"
KEYWORDS="~amd64 ppc x86"
IUSE=""
SLOT="0"
DEPEND=">=media-libs/jpeg-6b
		>=sys-libs/zlib-1.1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-amd64grey.patch"
}

# no configure for this puppy
src_compile() {
	#note: We override CDEBUGFLAGS instead of CFLAGS because otherwise
	#      we lost the INCLUDES in the makefile.
	# bug #295741
	emake -j1 CDEBUGFLAGS="${CFLAGS}" || die "make failed"
}

# likewise, no make install (we're real Unix hackers, we are)
src_install() {
	dobin vncsnapshot || die
	cp vncsnapshot.man1 vncsnapshot.1
	doman vncsnapshot.1
}
