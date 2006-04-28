# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bless/bless-0.4.0.ebuild,v 1.4 2006/04/28 20:46:17 compnerd Exp $

inherit mono eutils

DESCRIPTION="GTK# Hex Editor"
HOMEPAGE="http://home.gna.org/bless/"
SRC_URI="http://download.gna.org/bless/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.10
		 >=dev-dotnet/gtk-sharp-2
		 >=dev-dotnet/glade-sharp-2"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch for >=mono-1.1.10 (Mono.Unix -> Mono.Unix.Native)
	epatch ${FILESDIR}/${PN}-0.4.0-namespace.patch

	# Patch for strictness.  Iterators are not mutable
	epatch ${FILESDIR}/${PN}-0.4.0-strictness.patch
}

src_compile() {
	econf --enable-unix-specific --without-scrollkeeper || die "conf failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS ChangeLog README
}
