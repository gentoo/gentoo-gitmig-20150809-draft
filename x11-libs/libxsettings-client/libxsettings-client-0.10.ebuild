# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxsettings-client/libxsettings-client-0.10.ebuild,v 1.2 2004/04/11 14:56:41 pyrania Exp $

IUSE=""

DESCRIPTION="xsettings provides inter toolkit configuration settings"
HOMEPAGE="http://www.freedesktop.org/standards/xsettings-spec/"
SRC_URI="http://handhelds.org/~mallum/downloadables/Xsettings-client-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

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
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
