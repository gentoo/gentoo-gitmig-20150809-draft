# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.8.1.ebuild,v 1.2 2005/02/12 21:07:09 eradicator Exp $

IUSE="mad oggvorbis alsa"

inherit virtualx

DESCRIPTION="Quod Libet is a new kind of audio player."
HOMEPAGE="http://www.sacredchao.net/~piman/software/quodlibet.shtml"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc ~x86"

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.4.1
	oggvorbis? ( dev-python/pyvorbis )
	mad? ( dev-python/pymad
		dev-python/pyid3lib )
	alsa? ( dev-python/pyao )"

src_compile() {
	Xemake || die
}

src_install() {
	Xmake DESTDIR=${D} install || die
	dodoc TODO README NEWS
}
