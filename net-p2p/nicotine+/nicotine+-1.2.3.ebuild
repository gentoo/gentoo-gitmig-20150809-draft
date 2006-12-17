# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nicotine+/nicotine+-1.2.3.ebuild,v 1.5 2006/12/17 16:20:44 dertobi123 Exp $

inherit distutils eutils multilib toolchain-funcs

DESCRIPTION="A fork of nicotine, a Soulseek client in Python"
HOMEPAGE="http://www.nicotine-plus.org"

SRC_URI="http://thegraveyard.org/daelstorm/nicotine/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86 ~x86-fbsd"
IUSE="vorbis geoip"

RDEPEND="virtual/python
	>=dev-python/pygtk-2
	vorbis? ( >=dev-python/pyvorbis-1.4-r1
			  >=dev-python/pyogg-1 )
	geoip? ( >=dev-python/geoip-python-0.2.0
			 >=dev-libs/geoip-1.2.1 )
	!net-p2p/nicotine"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-apps/sed-4"

src_compile() {
	distutils_src_compile

	cd "${S}"/trayicon/
	sed -i -e "s:/lib/:/$(get_libdir)/:" \
		Makefile.in || die "sed failed"
	./autogen.py
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	distutils_python_version
	distutils_src_install --install-lib \
		/usr/$(get_libdir)/python${PYVER}/site-packages

	cd "${S}"/trayicon/
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon ${FILESDIR}/nicotine-n.png
	domenu ${FILESDIR}/${PN}.desktop
}
