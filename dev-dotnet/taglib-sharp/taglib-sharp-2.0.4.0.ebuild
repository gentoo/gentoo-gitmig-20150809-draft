# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/taglib-sharp/taglib-sharp-2.0.4.0.ebuild,v 1.4 2011/11/05 12:21:37 hwoarang Exp $

EAPI=4
inherit mono

DESCRIPTION="Taglib# 2.0 - Managed tag reader/writer"
HOMEPAGE="http://developer.novell.com/wiki/index.php/TagLib_Sharp"
SRC_URI="http://download.banshee-project.org/${PN}/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-lang/mono"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	sed -i	-e "s:docs::" \
		-e "s:examples::" \
		Makefile.in || die "sedding sense into makefiles failed"
}

src_configure() {
	econf --disable-docs
}
