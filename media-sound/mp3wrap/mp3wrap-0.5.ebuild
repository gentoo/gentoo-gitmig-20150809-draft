# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3wrap/mp3wrap-0.5.ebuild,v 1.13 2005/09/04 10:56:50 flameeyes Exp $

IUSE=""

DESCRIPTION="Command-line utility that wraps quickly two or more mp3 files in one single large playable mp3."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"
HOMEPAGE="http://mp3wrap.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND=""

src_install() {
	dobin mp3wrap
	doman mp3wrap.1
	dodoc AUTHORS ChangeLog README
	dohtml doc/*.html
}
