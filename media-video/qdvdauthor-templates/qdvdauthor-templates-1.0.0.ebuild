# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qdvdauthor-templates/qdvdauthor-templates-1.0.0.ebuild,v 1.1 2008/06/08 23:09:02 sbriesen Exp $

inherit eutils

DESCRIPTION="Templates for 'Q' DVD-Author"
HOMEPAGE="http://qdvdauthor.sourceforge.net/"
SRC_URI="mirror://sourceforge/qdvdauthor/${P}.tar.bz2"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/qdvdauthor-1.2.0"
RDEPEND="${DEPEND}"

src_compile() {
	: # nothing to do
}

src_install() {
	insinto /usr/share/qdvdauthor
	for i in animated buttons static; do
		doins -r ${i}
	done
}
