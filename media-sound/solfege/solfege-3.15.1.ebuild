# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/solfege/solfege-3.15.1.ebuild,v 1.1 2009/05/11 13:06:44 ssuominen Exp $

EAPI=2

DESCRIPTION="GNU Solfege is a program written to help you practice ear training."
HOMEPAGE="http://www.solfege.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="oss"

RDEPEND=">=dev-lang/python-2.5
	gnome-base/librsvg
	virtual/ghostscript
	>=dev-python/pygtk-2.12"
DEPEND="${RDEPEND}
	dev-lang/swig
	sys-devel/gettext
	sys-apps/texinfo
	dev-util/pkgconfig
	dev-libs/libxslt
	app-text/txt2man
	>=app-text/docbook-xsl-stylesheets-1.60"

src_configure() {
	local xslloc=$( xmlcatalog /etc/xml/catalog	http://docbook.sourceforge.net/release/xsl/current/html/chunk.xsl | sed 's@file://@@' )

	econf \
		--enable-docbook-stylesheet=${xslloc} \
		$(use_enable oss oss-sound)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS *hange*og FAQ README
}
