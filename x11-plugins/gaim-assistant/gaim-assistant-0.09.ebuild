# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-assistant/gaim-assistant-0.09.ebuild,v 1.1 2005/01/06 18:58:19 rizzo Exp $

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
