# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vco-plugins/vco-plugins-0.2.1.ebuild,v 1.3 2004/05/10 23:24:30 lv Exp $

IUSE=""
#
MY_P=${P/vco/VCO}

DESCRIPTION="SAW-VCO ladspa plugin package. Anti-aliased oscillator"
HOMEPAGE="http://alsamodular.sourceforge.net/"
SRC_URI="http://alsamodular.sourceforge.net/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

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
