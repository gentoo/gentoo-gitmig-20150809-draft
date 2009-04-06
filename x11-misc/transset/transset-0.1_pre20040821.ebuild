# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/transset/transset-0.1_pre20040821.ebuild,v 1.14 2009/04/06 18:48:14 bluebird Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="Set the transparency levels of windows in an X11 environment"
HOMEPAGE="http://xorg.freedesktop.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"

RDEPEND="!<=x11-base/xorg-x11-6.7.99.902
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-libs/libX11"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	dobin transset
	dodoc ChangeLog
}
