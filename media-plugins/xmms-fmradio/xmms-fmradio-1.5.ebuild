# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-fmradio/xmms-fmradio-1.5.ebuild,v 1.11 2005/03/28 09:23:29 eradicator Exp $

IUSE=""

inherit toolchain-funcs

MY_P=${P/fmr/FMR}
S=${WORKDIR}/${MY_P}
DESCRIPTION="radio tuner Plugin for XMMS"
HOMEPAGE="http://silicone.free.fr/xmms-FMRadio/"
SRC_URI="http://silicone.free.fr/xmms-FMRadio/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc"

RDEPEND="media-sound/xmms"

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe libradio.so || die
	dodoc INSTALL README
}
