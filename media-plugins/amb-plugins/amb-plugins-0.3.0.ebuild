# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/amb-plugins/amb-plugins-0.3.0.ebuild,v 1.2 2008/08/13 11:19:31 armin76 Exp $

inherit multilib toolchain-funcs

MY_P=${P/amb/AMB}

DESCRIPTION="AMB-plugins ladspa plugin package. Filters by Fons Adriaensen"
HOMEPAGE="http://www.kokkinizita.net/linuxaudio/"
SRC_URI="http://www.kokkinizita.net/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

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
