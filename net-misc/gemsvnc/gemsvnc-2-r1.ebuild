# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gemsvnc/gemsvnc-2-r1.ebuild,v 1.5 2004/08/11 22:45:12 slarti Exp $

inherit eutils gcc flag-o-matic

DESCRIPTION="an X11 vnc server for remote control"
HOMEPAGE="http://www.elilabs.com/~rj/gemsvnc/"
#SRC_URI="http://www.elilabs.com/~rj/gemsvnc/${PN}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa ~amd64"
IUSE=""

DEPEND=">=net-libs/libvncserver-0.6
	virtual/x11
	sys-libs/zlib
	media-libs/jpeg"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-daemon-runforever.patch
	epatch ${FILESDIR}/${PV}-many-bpp.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin gemsvnc || die
	dodoc CHANGES README TODO
}
