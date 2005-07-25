# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-0.11-r1.ebuild,v 1.2 2005/07/25 19:09:07 dholm Exp $

inherit virtualx

DESCRIPTION="Quod Libet is a new kind of audio player."
HOMEPAGE="http://www.sacredchao.net/quodlibet"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="alsa mad vorbis"

DEPEND=">=virtual/python-2.3
	>=dev-python/pygtk-2.4.1
	alsa? ( dev-python/pyao )
	mad? ( dev-python/pymad
		dev-python/pyid3lib )
	vorbis? ( dev-python/pyvorbis )"

src_compile() {
	Xemake || die "make failed"
	Xemake extensions || die "make extensions failed"
}

src_install() {
	Xmake PREFIX=/usr DESTDIR=${D} install || die "make install failed"
	dodoc TODO README NEWS
}
