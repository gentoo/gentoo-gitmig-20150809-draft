# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/taglib-sharp/taglib-sharp-2.0.3.0.ebuild,v 1.7 2009/01/26 15:35:37 loki_val Exp $

EAPI=2

inherit autotools mono eutils

DESCRIPTION="Taglib# 2.0 - Managed tag reader/writer"
HOMEPAGE="http://www.taglib-sharp.com"
SRC_URI="http://download.banshee-project.org/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-lang/mono"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${PN}-fix-docs-test.patch"
	eautoreconf
	sed -i	-e "s:   docs::" \
		-e "s:   examples::" \
		Makefile.in || die "sedding sense into makefiles failed"
}

src_configure() {
	econf --disable-docs
}

src_install()  {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
