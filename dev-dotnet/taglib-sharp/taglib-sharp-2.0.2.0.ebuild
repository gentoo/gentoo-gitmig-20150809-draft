# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/taglib-sharp/taglib-sharp-2.0.2.0.ebuild,v 1.3 2008/04/26 09:40:23 cedk Exp $

EAPI=1

inherit autotools mono eutils

DESCRIPTION="Taglib# 2.0 - Managed tag reader/writer"
HOMEPAGE="http://www.taglib-sharp.com"
SRC_URI="http://www.taglib-sharp.com/Download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gnome"

RDEPEND="dev-lang/mono
		 gnome? ( >=dev-dotnet/gnome-sharp-2.0 )
		 doc? ( dev-util/monodoc )"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.20"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Cleaning up docdir mess (bug #184149)
	epatch "${FILESDIR}"/${PN}-fix-docdir.patch
	# taglib-sharp configure script is a bit messed up
	epatch "${FILESDIR}"/${PN}-fix-docs-test.patch
	# Fix sandbox violation on /usr/lib/monodoc/monodoc.xml
	epatch "${FILESDIR}"/${PN}-fix-sandbox-violation.patch
	# Allow gnome-sharp to be an optional dependency
	epatch "${FILESDIR}"/${PN}-gnome-sharp-toggle.patch

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf \
		$(use_enable doc docs) \
		$(use_enable gnome gnome-sharp) || die "configure failed"

	emake -j1 || die "make failed"
}

src_install()  {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
