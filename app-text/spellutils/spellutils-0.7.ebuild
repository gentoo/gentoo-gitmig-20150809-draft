# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/spellutils/spellutils-0.7.ebuild,v 1.7 2004/09/12 15:54:21 slarti Exp $

IUSE="nls"

DESCRIPTION="spellutils includes 'newsbody' (useful for spellchecking in mails, etc.)"
HOMEPAGE="http://home.worldonline.dk/byrial/spellutils/"
SRC_URI="http://home.worldonline.dk/byrial/spellutils/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha ~mips ~hppa ~amd64"

DEPEND="virtual/libc"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall
	dodoc FILES NEWS README ABOUT-NLS COPYING INSTALL
}
