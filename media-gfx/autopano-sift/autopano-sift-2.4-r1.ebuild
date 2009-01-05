# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autopano-sift/autopano-sift-2.4-r1.ebuild,v 1.9 2009/01/05 17:22:26 loki_val Exp $

inherit mono eutils

DESCRIPTION="SIFT algorithm for automatic panorama creation"
HOMEPAGE="http://user.cs.tu-berlin.de/~nowozin/autopano-sift/"
SRC_URI="http://user.cs.tu-berlin.de/~nowozin/autopano-sift/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE=""

RDEPEND="!media-gfx/autopano-sift-C
	dev-lang/mono
	dev-dotnet/glade-sharp
	dev-dotnet/gtk-sharp
	>=dev-dotnet/libgdiplus-1.1.11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	cd "${S}"/src
	sed -i 's%^AUTOPANO_PATH=.*%AUTOPANO_PATH=/usr/lib/autopano-sift%' \
		bin/autopano-complete.sh
	if has_version '>=dev-dotnet/gtk-sharp-2' ; then
		sed -i 's%pkg:gtk-sharp%pkg:gtk-sharp-2.0%g' Makefile util/Makefile \
			util/autopanog/Makefile || die "sed failed"
	fi
	if has_version '>=dev-dotnet/glade-sharp-2' || has_version '>=dev-dotnet/gtk-sharp-2.12.6' ; then
		sed -i 's%pkg:glade-sharp%pkg:glade-sharp-2.0%g' util/Makefile \
			util/autopanog/Makefile || die "sed failed"
	fi
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

	dodoc README CHANGES
	cd "${S}"/doc
	rm -f template.1 autopano-complete.old.*
	dodoc *.pdf *.txt
	doman *.1 *.7
}
