# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/ignorance/ignorance-1.3.1.1.ebuild,v 1.1 2005/06/21 02:27:02 anarchy Exp $

inherit eutils

DESCRIPTION="GAIM Advanced Ignore filter"
HOMEPAGE="http://bard.sytes.net/ignorance/"
SRC_URI="http://bard.sytes.net/ignorance/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=net-im/gaim-1.0.1"

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc ChangeLog INSTALL README AUTHORS
}
