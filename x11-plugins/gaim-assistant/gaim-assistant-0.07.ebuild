# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-assistant/gaim-assistant-0.07.ebuild,v 1.1 2004/12/08 16:28:31 rizzo Exp $

inherit eutils

DESCRIPTION="Gaim Assistant is a plugin to Gaim that will allow you to forward messages to a different screen name should you become away."
HOMEPAGE="http://gaim-assistant.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0"
#RDEPEND=""

#S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README TODO
}
