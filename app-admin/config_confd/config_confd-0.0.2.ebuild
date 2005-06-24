# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/config_confd/config_confd-0.0.2.ebuild,v 1.1 2005/06/24 10:01:36 dams Exp $

MY_P=${PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Configuration editor for the /etc/conf.d files"
HOMEPAGE="http://libconf.net/config_confd/"
SRC_URI="http://libconf.net/config_confd/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~ppc64 ~sparc ~x86 ~amd64"

IUSE=""
DEPEND=">=dev-util/libconf-0.39.21
>=dev-perl/gtk2-fu-0.10"

src_compile() {
	emake || die "make failed"
}

src_install() {
	einstall PREFIX=${D}/usr
}
