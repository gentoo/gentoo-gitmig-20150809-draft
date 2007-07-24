# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/playspc_gtk/playspc_gtk-0.2.7.8.ebuild,v 1.1 2007/07/24 15:35:54 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Playspc_gtk is a gtk program utilizing the SNeSe SPC core to play SPC files.  RAR support is well integrated."
HOMEPAGE="http://playspc.sourceforge.net"
SRC_URI="mirror://sourceforge/playspc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# -*: Contains x86 assembly
KEYWORDS="-* ~x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_compile() {
	cd "${S}"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	dolib.so libopenspc/libopenspc.so
	dobin ${PN} spccore
	dodoc CHANGELOG README TODO
	doicon playspc-icon.png
	make_desktop_entry ${PN} ${PN} playspc-icon.png
}
