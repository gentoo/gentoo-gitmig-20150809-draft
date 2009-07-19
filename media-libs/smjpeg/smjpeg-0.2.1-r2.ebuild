# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smjpeg/smjpeg-0.2.1-r2.ebuild,v 1.18 2009/07/19 17:30:59 ssuominen Exp $

EAPI=2

DESCRIPTION="SDL Motion JPEG Library"
SRC_URI="ftp://ftp.linuxgames.com/loki/open-source/smjpeg/${P}.tar.gz"
HOMEPAGE="http://www.lokigames.com/development/smjpeg.php3"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="sparc x86"
IUSE="nas"

RDEPEND=">=media-libs/libsdl-1.1.7"
DEPEND="${RDEPEND}"

src_configure() {
	# FIXME
	use nas && LDFLAGS="-lXt"
	LDFLAGS="${LDFLAGS}" econf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES README TODO SMJPEG.txt
}
