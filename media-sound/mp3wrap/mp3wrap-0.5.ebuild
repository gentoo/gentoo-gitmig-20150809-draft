# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3wrap/mp3wrap-0.5.ebuild,v 1.3 2003/07/12 20:30:54 aliz Exp $

DESCRIPTION="Command-line utility that wraps quickly two or more mp3 files in one single large playable mp3."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

IUSE=""

DEPEND=""

src_install() {
  dobin mp3wrap
  doman mp3wrap.1
  dodoc AUTHORS ChangeLog COPYING INSTALL README
  dohtml doc/*.html
}

