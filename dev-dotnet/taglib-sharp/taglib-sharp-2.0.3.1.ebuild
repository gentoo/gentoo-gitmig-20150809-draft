# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/taglib-sharp/taglib-sharp-2.0.3.1.ebuild,v 1.3 2009/01/27 14:46:46 loki_val Exp $

EAPI=2

inherit mono

DESCRIPTION="Taglib# 2.0 - Managed tag reader/writer"
HOMEPAGE="http://www.taglib-sharp.com"
SRC_URI="http://download.banshee-project.org/${PN}/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/mono"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
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
