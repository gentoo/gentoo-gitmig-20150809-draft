# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticables/libticables-3.9.6.ebuild,v 1.1 2006/03/15 04:39:07 ribosome Exp $

inherit eutils

DESCRIPTION="Link cables support for the TiLP calculator linking program"
HOMEPAGE="http://tilp.info/"
#SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz"
SRC_URI="http://nico.hibou.free.fr/hibnet/gentoo/distfiles/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug nls"

RDEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	sys-devel/bison"

src_compile() {
	local myconf="$(use_enable nls) $(use_enable debug logging)"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
	dobin ticables-config
	dodoc AUTHORS LOGO NEWS README
	doman ticables-config.1
}

pkg_postinst() {
	einfo "To use \"${PN}\", you might need one of the following"
	einfo "kernel modules: \"tipar\", \"tiser\" or \"tiusb\". If you install"
	einfo "one of these modules, you might have to reinstall"
	einfo "\"${PN}\". Please read the file:"
	einfo "\"/usr/share/doc/${PF}/README.gz\" for more"
	einfo "details."
}
