# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxsettings-client/libxsettings-client-0.10.ebuild,v 1.6 2005/10/31 13:28:24 nelchael Exp $

IUSE=""

DESCRIPTION="xsettings provides inter toolkit configuration settings"
HOMEPAGE="http://www.freedesktop.org/standards/xsettings-spec/"
SRC_URI="http://handhelds.org/~mallum/downloadables/Xsettings-client-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

DEPEND="sys-devel/libtool
	virtual/x11"

#RDEPEND=""

S=${WORKDIR}/Xsettings-client-${PV}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
