# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3wrap/mp3wrap-0.5.ebuild,v 1.10 2004/11/23 09:50:49 eradicator Exp $

IUSE=""

DESCRIPTION="Command-line utility that wraps quickly two or more mp3 files in one single large playable mp3."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~sparc x86"

DEPEND=""

src_install() {
	dobin mp3wrap
	doman mp3wrap.1
	dodoc AUTHORS ChangeLog COPYING INSTALL README
	dohtml doc/*.html
}
