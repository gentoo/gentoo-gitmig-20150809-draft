# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/taglib-sharp/taglib-sharp-2.0.3.2.ebuild,v 1.4 2010/09/26 17:06:56 zmedico Exp $

EAPI=2

inherit mono

DESCRIPTION="Taglib# 2.0 - Managed tag reader/writer"
HOMEPAGE="http://developer.novell.com/wiki/index.php/TagLib_Sharp"
SRC_URI="http://download.banshee-project.org/${PN}/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
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
