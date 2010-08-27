# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/rev-plugins/rev-plugins-0.3.1.ebuild,v 1.5 2010/08/27 05:21:01 jer Exp $

inherit multilib toolchain-funcs

MY_P=${P/rev/REV}

DESCRIPTION="REV LADSPA plugins package. A stereo reverb plugin based on the well-known greverb"
HOMEPAGE="http://www.kokkinizita.net/linuxaudio/"
SRC_URI="http://www.kokkinizita.net/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

DEPEND="media-libs/ladspa-sdk"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	tc-export CXX
	sed -i -e "s/-O2//" Makefile
	sed -i -e "s/g++/$(tc-getCXX)/" Makefile
	emake || die
}

src_install() {
	dodoc AUTHORS README
	insinto /usr/$(get_libdir)/ladspa
	insopts -m0755
	doins *.so
}
