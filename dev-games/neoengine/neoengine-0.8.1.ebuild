# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neoengine/neoengine-0.8.1.ebuild,v 1.5 2004/08/13 09:06:37 mr_bones_ Exp $

inherit eutils

DESCRIPTION="An open source, platform independent, 3D game engine written in C++"
HOMEPAGE="http://www.neoengine.org/"
SRC_URI="mirror://sourceforge/neoengine/${P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="virtual/opengl
	media-libs/alsa-lib
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${P}/neoengine"

src_compile() {
	local i

	econf \
		--disable-dependency-tracking \
		|| die
	emake || die "emake failed"

	if use doc; then
		for i in "*.doxygen"; do
			doxygen ${i}
		done
	fi
}

src_install() {
	local i

	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL README TODO

	if use doc; then
		dodir /usr/share/doc/${PF}
		for i in "*-api"; do
			cp -r ${i} "${D}/usr/share/doc/${PF}"
		done
	fi
}
