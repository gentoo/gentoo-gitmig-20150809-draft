# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/rev-plugins/rev-plugins-0.2.1.ebuild,v 1.5 2004/06/24 23:34:35 agriffis Exp $
#
MY_P=${P/rev/REV}

DESCRIPTION="REV ladspa plugins package. Looks like a nive reverb"
HOMEPAGE="http://alsamodular.sourceforge.net/"
SRC_URI="http://alsamodular.sourceforge.net/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

IUSE=""

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	make || die
}

src_install() {
	dodoc AUTHORS COPYING README ${S}/ams/*
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
}
