# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faad2/faad2-1.1.ebuild,v 1.14 2004/07/24 05:56:56 eradicator Exp $

inherit eutils

HOMEPAGE="http://faac.sourceforge.net/"
SRC_URI="mirror://sourceforge/faac/${P}.tar.gz"
LICENSE="GPL-2"
DESCRIPTION="FAAD2 is the fastest ISO AAC audio decoder available. FAAD2 correctly decodes all MPEG-4 and MPEG-2 MAIN, LOW, LTP, LD and ER object type AAC files."
S="${WORKDIR}/${PN}"
IUSE=""
KEYWORDS="x86 ppc ~sparc amd64"
RDEPEND=">=media-libs/libsndfile-1.0.1
	 !media-video/mpeg4ip"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.4.1-r10
	sys-devel/automake
	sys-devel/autoconf"

SLOT="0"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	./bootstrap
	econf || die "econf failed"
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
