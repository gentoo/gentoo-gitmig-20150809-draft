# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/eblook/eblook-1.5.1.ebuild,v 1.5 2004/04/06 03:32:48 vapier Exp $

inherit eutils

DESCRIPTION="EBlook is an interactive search utility for electronic dictionaries"
HOMEPAGE="http://openlab.ring.gr.jp/edict/eblook/"
SRC_URI="http://openlab.ring.gr.jp/edict/eblook/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=dev-libs/eb-3.3.4"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.53"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-eb4-gentoo.diff
}

src_compile() {
	autoreconf || die

	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README VERSION
}
