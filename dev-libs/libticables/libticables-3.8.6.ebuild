# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libticables/libticables-3.8.6.ebuild,v 1.4 2004/12/02 10:14:25 pylon Exp $

DESCRIPTION="Link cables support for the TiLP calculator linking program"
HOMEPAGE="http://tilp.info/"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc"
IUSE="debug nls"

RDEPEND="virtual/libc
	nls? sys-devel/gettext"

DEPEND="${RDEPEND}
	sys-devel/bison"

S=${WORKDIR}/${P}-gentoo

src_compile() {
	local myconf="$(use_enable nls) $(use_enable debug logging)"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
	dobin ticables-config
	dodoc AUTHORS ChangeLog LOGO README
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
