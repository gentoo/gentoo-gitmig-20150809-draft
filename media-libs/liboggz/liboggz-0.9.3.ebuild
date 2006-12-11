# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liboggz/liboggz-0.9.3.ebuild,v 1.2 2006/12/11 10:55:01 zaheerm Exp $

DESCRIPTION="Oggz provides a simple programming interface for reading and writing Ogg files and streams"
HOMEPAGE="http://www.annodex.net/software/liboggz/"
SRC_URI="http://www.annodex.net/software/liboggz/download/${P}.tar.gz"
LICENSE="as-is"

KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"
IUSE="doc"
RDEPEND="media-libs/libogg"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS COPYING ChangeLog INSTALL \
	  NEWS README TODO"

src_install()
{
	make DESTDIR=${D} install
}
