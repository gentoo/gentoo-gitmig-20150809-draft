# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/taglib-sharp/taglib-sharp-1.9.75474.ebuild,v 1.1 2007/09/10 19:22:45 jurek Exp $

inherit mono eutils

DESCRIPTION="Taglib C# binding"
HOMEPAGE="http://developer.novell.com/wiki/index.php/TagLib_Sharp"
SRC_URI="http://developer.novell.com/wiki/index.php/Special:File/${PN}/${P}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1"
DEPEND="${RDEPEND}
		doc? ( >=dev-util/monodoc-1.1.9
				app-arch/unzip )
		media-libs/taglib"

src_compile() {
	# taglib-sharp configure script is a bit messed up
	if use doc; then
		econf $(use_with doc docs) || die "configure failed"
	else
		econf $(use_enable doc docs) || die "configure failed"
	fi

	emake -j1 || die "make failed"
}

src_install()  {
	# cleaning up docdir mess (bug #184149)
	sed -i -e 's#^docdir = ${datarootdir}/doc/${PACKAGE}$##' \
		-e 's#^docdir = $(DESTDIR)$(DOCDIR)$#docdir = $(DOCDIR)#' \
		docs/Makefile \
	|| die "sed failed"

	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
