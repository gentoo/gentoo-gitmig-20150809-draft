# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/solfege/solfege-3.10.4.ebuild,v 1.2 2008/12/04 20:48:57 eva Exp $

DESCRIPTION="GNU Solfege is a program written to help you practice ear training."
HOMEPAGE="http://www.solfege.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="oss"

# FIXME: there is probably some missing python deps, please fill bugs.
RDEPEND=">=dev-python/pygtk-2.6
	>=dev-python/libgnome-python-2.20
	>=dev-python/gtkhtml-python-2.19"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	=dev-lang/swig-1.3*
	sys-devel/gettext
	sys-apps/texinfo
	dev-libs/libxslt
	>=app-text/docbook-xsl-stylesheets-1.60"

src_unpack() {
	unpack ${A}
	# Make sure it doesn't compile python at install time for bug 210305.
	sed -i -e 's:compileall::' "${S}"/Makefile.in || die "sed failed."
}

src_compile() {
	# Try to figure out where is this damn stylesheet.
	local xslloc=$( xmlcatalog /etc/xml/catalog	http://docbook.sourceforge.net/release/xsl/current/html/chunk.xsl | sed 's@file://@@' )

	econf --enable-docbook-stylesheet=${xslloc} \
		$(use_enable oss oss-sound) \
		--disable-pygtk-test

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS *hange*og FAQ README
}
