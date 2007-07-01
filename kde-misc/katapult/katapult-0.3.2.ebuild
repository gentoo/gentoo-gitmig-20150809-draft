# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/katapult/katapult-0.3.2.ebuild,v 1.1 2007/07/01 20:59:11 philantrop Exp $

USE_KEG_PACKAGING="1"
LANGS="ar br cs de es fr gl it nb pl pt_BR sk tr bg ca da el et ga hu ja nl pt ru sv uk"
LANGS_DOC=""

inherit kde

DESCRIPTION="KDE application to allow fast access to applications, bookmarks and other items."
HOMEPAGE="http://www.thekatapult.org.uk/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

need-kde 3.3
