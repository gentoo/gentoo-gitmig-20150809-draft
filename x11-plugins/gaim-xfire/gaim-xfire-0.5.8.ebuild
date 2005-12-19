# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-xfire/gaim-xfire-0.5.8.ebuild,v 1.1 2005/12/19 16:06:19 gothgirl Exp $

inherit eutils

DESCRIPTION="Xfire plugin for gaim. It's in early state of development. You
can have a chat, add and remove buddies from contact list, seeing what game a buddy
is playing."

HOMEPAGE="http://www.fryx.ch/xfire/"

SRC_URI="mirror://sourceforge/gfire/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="debug"

DEPEND=">=net-im/gaim-1.0.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
		./configure || die "Configure failed"
		emake
}

src_install() {
		einstall || die "Install failed"
} 
