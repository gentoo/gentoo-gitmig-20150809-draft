# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-1.1.ebuild,v 1.3 2003/04/28 02:24:39 lu_zero Exp $

inherit eutils

HOMEPAGE="http://faac.sourceforge.net/"
SRC_URI="http://faac.sourceforge.net/files/${P}.tar.gz"
LICENSE="GPL-2"
DESCRIPTION="FAAD2 is the fastest ISO AAC audio decoder available. FAAD2 correctly decodes all MPEG-4 and MPEG-2 MAIN, LOW, LTP, LD and ER object type AAC files."
S="${WORKDIR}/${PN}"
IUSE=""
KEYWORDS="~x86 ~ppc"
DEPEND=">=media-libs/libsndfile-1.0.1
	>=libtool-1.4.1-r10
	sys-devel/automake
	sys-devel/autoconf"
SLOT="0"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	./bootstrap
	econf
	cd frontend
	cp Makefile Makefile.orig
	sed -e "s:CCLD = \$(CC):CCLD = \$(CXX):" Makefile.orig > Makefile
	cd ${S}
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.linux TODO
}
