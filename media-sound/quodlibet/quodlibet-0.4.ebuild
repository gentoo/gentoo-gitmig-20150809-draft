# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.4.ebuild,v 1.1 2004/11/12 21:07:58 pkdawson Exp $

DESCRIPTION="Quod Libet is a new kind of audio player."
HOMEPAGE="http://www.sacredchao.net/~piman/software/quodlibet.shtml"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="mad oggvorbis"

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.4
	oggvorbis? ( dev-python/pyvorbis )
	mad? ( dev-python/pymad
		dev-python/pyid3lib )"

# add this to DEPEND once pyflac is in portage
# flac? ( dev-python/pyflac )

src_install() {
	make DESTDIR=${D} install || die
	dodoc TODO README NEWS
}
