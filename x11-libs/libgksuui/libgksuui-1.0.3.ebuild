# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libgksuui/libgksuui-1.0.3.ebuild,v 1.1 2005/05/01 05:01:44 dragonheart Exp $

MY_PN="${PN}1.0"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}


DESCRIPTION="A UI-library for libgksu"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.0.0"

src_compile() {
	econf `use_enable nls`|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
