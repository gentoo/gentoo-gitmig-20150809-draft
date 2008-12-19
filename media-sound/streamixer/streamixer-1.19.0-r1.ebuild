# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamixer/streamixer-1.19.0-r1.ebuild,v 1.1 2008/12/19 17:50:23 aballier Exp $


inherit eutils toolchain-funcs

DESCRIPTION="Various audio stream handling tools (non-interactive)"
HOMEPAGE="http://bisqwit.iki.fi/source/streamixer.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

#-sparc: 1.19.0: bad assembly
KEYWORDS="~amd64 -sparc ~x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="sys-apps/sed"
IUSE=""

INSTALLPROGS="resample mixer mixwrite mixeridle ecat hum mixerscript"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:BINDIR=/usr/local/bin:BINDIR=${D}usr/bin:" \
		-e "s:^\\(ARGHLINK.*-L.*\\):#\\1:" \
		-e "s:^#\\(ARGHLINK=.*a\\)$:\\1:" \
		-e "s:\$(CXX):\$(CXX) \$(CXXFLAGS) -I${S}/argh:g" \
		Makefile

	sed -i \
		-e 's:CPPFLAGS=:CPPFLAGS=-I/var/tmp/portage/erec-2.2.0.1/work/erec-2.2.0.1/argh :' \
		Makefile.sets

	echo "" > .depend
	echo "" > argh/.depend
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" -C argh libargh.a || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" ${INSTALLPROGS} || die
}

src_install() {
	dobin ${INSTALLPROGS}
	dohard /usr/bin/mixwrite /usr/bin/mixmon
	dodoc README
	dohtml README.html
}
