# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsaequal/alsaequal-0.4.ebuild,v 1.2 2009/09/30 08:40:41 fauli Exp $

inherit multilib toolchain-funcs

DESCRIPTION="a real-time adjustable equalizer plugin for ALSA"
HOMEPAGE="http://www.thedigitalmachine.net/alsaequal.html"
SRC_URI="http://www.thedigitalmachine.net/tools/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	media-plugins/caps-plugins"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -Wall -fPIC -DPIC" \
		LD="$(tc-getCC)" LDFLAGS="${LDFLAGS} -shared" || die "emake failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/alsa-lib
	doexe *.so || die "doexe failed"
	dodoc README || die "dodoc failed"
}
