# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/liveice/liveice-2000530-r1.ebuild,v 1.1 2010/09/18 05:03:11 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Live Source Client For IceCast"
HOMEPAGE="http://star.arm.ac.uk/~spm/software/liveice.html"
SRC_URI="http://star.arm.ac.uk/~spm/software/liveice.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-sound/lame
	media-sound/mpg123"
DEPEND=""

S=${WORKDIR}/${PN}

src_prepare() {
	# cannot use LDFLAGS directly as the Makefile uses it for LIBS
	sed -i Makefile.in \
		-e 's|-o liveice|$(LLFLAGS) &|' \
		|| die "sed Makefile.in"
	tc-export CC
}

src_compile() {
	emake LLFLAGS="${LDFLAGS}" || die
}
src_install() {
	dobin liveice || die
	dodoc liveice.cfg README.liveice README.quickstart README_new_mixer.txt Changes.txt
}
