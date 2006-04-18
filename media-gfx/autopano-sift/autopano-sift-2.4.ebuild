# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autopano-sift/autopano-sift-2.4.ebuild,v 1.4 2006/04/18 01:40:06 halcy0n Exp $

inherit mono eutils

DESCRIPTION="SIFT algorithm for automatic panorama creation"
HOMEPAGE="http://user.cs.tu-berlin.de/~nowozin/autopano-sift/"
SRC_URI="http://user.cs.tu-berlin.de/~nowozin/autopano-sift/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
IUSE=""

DEPEND="dev-lang/mono
	<dev-dotnet/glade-sharp-2
	<dev-dotnet/gtk-sharp-2
	>=dev-dotnet/libgdiplus-1.1.11"

src_unpack() {
	unpack ${A}

	cd "${S}"/src
	sed -i 's%^AUTOPANO_PATH=.*%AUTOPANO_PATH=/usr/lib/autopano-sift%' \
		bin/autopano-complete.sh
}

src_compile() {
	cd "${S}"/src

	emake -j1 || die "Compile failed"
}

src_install() {
	insinto /usr/lib/${PN}
	doins src/util/*.exe src/util/autopanog/*.exe src/libsift.dll

	exeinto /usr/bin

	doexe "${FILESDIR}"/autopano

	for file in autopanog generatekeys; do
		dosym autopano /usr/bin/"$file"
	done

	doexe src/bin/autopano-complete.sh

	dodoc README CHANGES LICENSE
	cd "${S}"/doc
	rm -f template.1 autopano-complete.old.*
	dodoc *.pdf *.txt
	doman *.1 *.7
}
