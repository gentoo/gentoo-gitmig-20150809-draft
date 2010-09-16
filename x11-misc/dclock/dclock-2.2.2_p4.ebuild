# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dclock/dclock-2.2.2_p4.ebuild,v 1.2 2010/09/16 23:18:51 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Digital clock for the X window system."
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV/_p*/}.orig.tar.gz
		mirror://debian/pool/main/d/${PN}/${PN}_${PV/_p/-}.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	app-text/rman"
DEPEND="${RDEPEND}
	x11-misc/imake"

S="${WORKDIR}/${P/_p*/}"

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX=diff epatch "${WORKDIR}"/debian/patches/
	epatch "${FILESDIR}"/${P}-include.patch
}

src_configure() {
	xmkmf || die "xmkmf"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}" \
		|| die "emake"
}

src_install() {
	emake DESTDIR="${D}" install || die
	emake DESTDIR="${D}" install.man || die
	insinto /usr/share/sounds
	doins sounds/* || die
	insinto /usr/share/X11/app-defaults
	newins Dclock.ad DClock || die
	dodoc README TODO
}
