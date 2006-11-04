# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxsettings-client/libxsettings-client-0.10.ebuild,v 1.11 2006/11/04 11:39:56 vapier Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit autotools

DESCRIPTION="provides inter toolkit configuration settings"
HOMEPAGE="http://www.freedesktop.org/standards/xsettings-spec/"
SRC_URI="http://handhelds.org/~mallum/downloadables/Xsettings-client-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ppc sh x86"
IUSE=""

DEPEND="|| ( (
		x11-proto/xproto
		x11-libs/libX11
		x11-libs/libXt )
	virtual/x11 )"

S=${WORKDIR}/Xsettings-client-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-as-needed.patch
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
