# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vco-plugins/vco-plugins-0.3.0.ebuild,v 1.6 2007/11/18 18:11:56 aballier Exp $

inherit multilib toolchain-funcs

IUSE=""
#
MY_P=${P/vco/VCO}

DESCRIPTION="SAW-VCO ladspa plugin package. Anti-aliased oscillators"
HOMEPAGE="http://www.kokkinizita.net/linuxaudio/"
SRC_URI="http://www.kokkinizita.net/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	tc-export CXX
	sed -i -e "s/-O3//" Makefile
	sed -i -e "s/g++/$(tc-getCXX)/" Makefile
	emake || die
}

src_install() {
	dodoc AUTHORS README
	insinto /usr/$(get_libdir)/ladspa
	insopts -m0755
	doins *.so
}
