# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musicman/musicman-0.15.ebuild,v 1.8 2009/06/04 19:53:18 ssuominen Exp $

EAPI=2
ARTS_REQUIRED=never
inherit eutils kde

DESCRIPTION="A Konqueror plugin for manipulating ID3 tags in MP3 files"
HOMEPAGE="http://musicman.sourceforge.net/"
SRC_URI="mirror://sourceforge/musicman/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="|| ( kde-base/libkonq:3.5
	kde-base/kdebase:3.5 )"
DEPEND="${RDEPEND}"

need-kde 3.5

PATCHES=( "${FILESDIR}/${PN}-0.11-amd64.patch" )

S=${WORKDIR}/${PN}
