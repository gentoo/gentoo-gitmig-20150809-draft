# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/taglib-sharp/taglib-sharp-2.0.3.0.ebuild,v 1.5 2008/12/14 15:28:29 loki_val Exp $

inherit autotools mono eutils

DESCRIPTION="Taglib# 2.0 - Managed tag reader/writer"
HOMEPAGE="http://www.taglib-sharp.com"
SRC_URI="http://www.taglib-sharp.com/Download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc gnome"

RDEPEND="dev-lang/mono
	gnome? ( >=dev-dotnet/gnome-sharp-2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( virtual/monodoc )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Cleaning up docdir mess (bug #184149)
	epatch "${FILESDIR}"/${P}-fix-docdir.patch
	# taglib-sharp configure script is a bit messed up
	epatch "${FILESDIR}"/${PN}-fix-docs-test.patch
	# Allow gnome-sharp to be an optional dependency
	epatch "${FILESDIR}"/${PN}-gnome-sharp-toggle.patch
	# Fix documentation building
	epatch "${FILESDIR}"/${P}-fix-doc-failure.patch

	eautoreconf
}

src_compile() {
	econf $(use_enable doc docs) \
		$(use_enable gnome gnome-sharp) || die "econf failed."
	emake -j1 || die "emake failed."
}

src_install()  {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
