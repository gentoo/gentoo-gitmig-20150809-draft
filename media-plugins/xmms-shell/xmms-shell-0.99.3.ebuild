# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shell/xmms-shell-0.99.3.ebuild,v 1.1 2003/06/21 01:39:08 jje Exp $

S=${WORKDIR}/${P}

DESCRIPTION="simple utility to control XMMS externally"
SRC_URI="mirror://sourceforge/xmms-shell/${P}.tar.gz"
HOMEPAGE="http://www.loganh.com/xmms-shell/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="readline"

DEPEND=">=media-sound/xmms-1.2.7
	readline? ( >=sys-libs/readline-4.1 )"

src_compile() {
	econf `use_with readline` || die "Configuration failed."
	emake || die "Make failed."
}

src_install() {
	make DESTDIR=${D} install || die "Install failed."
	dodoc AUTHORS ChangeLog INSTALL README
}

