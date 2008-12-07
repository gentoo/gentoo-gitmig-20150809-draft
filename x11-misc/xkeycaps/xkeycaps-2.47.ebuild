# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeycaps/xkeycaps-2.47.ebuild,v 1.1 2008/12/07 21:09:06 ssuominen Exp $

inherit eutils

DESCRIPTION="GUI frontend to xmodmap"
HOMEPAGE="http://packages.qa.debian.org/x/xkeycaps.html"
SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-misc/xbitmaps
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-misc/imake
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Imakefile.patch \
		"${FILESDIR}"/${P}-man.patch
}

src_compile() {
	xmkmf || die "xmkmf failed."
	sed -i -e "s,all:: xkeycaps.\$(MANSUFFIX).html,all:: ,g" \
		Makefile || die "sed failed."
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	newman ${PN}.man ${PN}.1
	dodoc README *.txt
}
