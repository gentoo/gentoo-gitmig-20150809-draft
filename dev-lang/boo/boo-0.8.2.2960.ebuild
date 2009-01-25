# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/boo/boo-0.8.2.2960.ebuild,v 1.2 2009/01/25 16:13:51 loki_val Exp $

inherit mono fdo-mime eutils autotools

DESCRIPTION="A wrist friendly language for the CLI"
HOMEPAGE="http://boo.codehaus.org/"
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.1.4
		dev-dotnet/nant
		x11-misc/shared-mime-info
		=x11-libs/gtksourceview-1*"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e \
		's#boo.lang##' extras/Makefile.am \
	|| die "sed failed"

	sed -i -e \
		's#^libdir=${prefix}/lib$#libdir=${prefix}/lib/mono#' \
		extras/boo.pc.in \
	|| die "sed failed"

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog README || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_mime_database_update
}
