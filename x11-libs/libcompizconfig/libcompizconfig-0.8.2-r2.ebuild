# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libcompizconfig/libcompizconfig-0.8.2-r2.ebuild,v 1.1 2009/07/16 18:12:21 jmbsvicetto Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Compiz Configuration System (git)"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxml2
	~x11-wm/compiz-${PV}"
DEPEND="${RDEPEND}
	>=dev-libs/iniparser-3.0b-r1
	dev-util/intltool
	>=dev-util/pkgconfig-0.19"

src_prepare() {

#	rm "${S}/src/iniparser.h" || die "Failed to remove ${S}/src/iniparser.h"
#	rm "${S}/src/iniparser.c" || die "Failed to remove ${S}/src/iniparser.c"

	epatch "${FILESDIR}/${P}-allow-system-libiniparser.patch"
	eautoreconf
}

src_configure() {
	econf \
		--without-internal-iniparser \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
