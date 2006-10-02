# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musicman/musicman-0.15.ebuild,v 1.4 2006/10/02 05:56:23 flameeyes Exp $

IUSE=""

inherit eutils kde

S="${WORKDIR}/musicman"

DESCRIPTION="A Konqueror plugin for manipulating ID3 tags in MP3 files"
HOMEPAGE="http://musicman.sourceforge.net/"
SRC_URI="mirror://sourceforge/musicman/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="|| ( kde-base/libkonq >=kde-base/kdebase-3.2.1 )"

need-kde 3.2

PATCHES="${FILESDIR}/${PN}-0.11-amd64.patch"

src_unpack() {
	kde_src_unpack

	rm -rf "${S}/admin" "${S}/configure"
	ln -s "${WORKDIR}/admin" "${S}/admin"
}
