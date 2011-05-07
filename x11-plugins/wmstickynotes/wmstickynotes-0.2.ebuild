# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmstickynotes/wmstickynotes-0.2.ebuild,v 1.1 2011/05/07 13:05:13 jlec Exp $

EAPI=4

DESCRIPTION="A dockapp for keeping small notes around on the desktop"
HOMEPAGE="http://wmstickynotes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}"
