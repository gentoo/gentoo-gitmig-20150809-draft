# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vco-plugins/vco-plugins-0.2.1.ebuild,v 1.1 2004/01/19 09:14:21 torbenh Exp $
#
MY_P=${P/vco/VCO}

DESCRIPTION="REV ladspa plugins package. Looks like a nive reverb"
HOMEPAGE="http://alsamodular.sourceforge.net/"
SRC_URI="http://alsamodular.sourceforge.net/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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
