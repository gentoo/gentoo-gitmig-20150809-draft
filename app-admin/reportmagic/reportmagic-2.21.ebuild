# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/reportmagic/reportmagic-2.21.ebuild,v 1.2 2004/04/28 21:34:52 dholm Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://www.reportmagic.org"
SRC_URI="http://www.reportmagic.org/rmagic-${PV}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="truetype"
DEPEND="sys-libs/zlib
	media-libs/libpng
	media-libs/libgd
	truetype? ( media-libs/freetype )
	media-libs/jpeg
	dev-perl/GD
	dev-perl/Config-IniFiles
	dev-perl/File-Spec
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/GDGraph
	dev-perl/File-Temp
	dev-perl/GD-Graph3d"
S=${WORKDIR}/rmagic-${PV}

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i -e "s:^\$DEST.*:\$DEST='${D}/usr/share/reportmagic';:g" \
		-e "s:^\$DOC.*:\$DOC='${D}/usr/share/doc/${PF}';:g" \
		Install.PL
}

src_install() {
	perl Install.PL -no_modules
}

