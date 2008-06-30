# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snips/snips-1.2-r1.ebuild,v 1.1 2008/06/30 12:18:52 chainsaw Exp $

inherit eutils toolchain-funcs

DESCRIPTION="System & Network Integrated Polling Software"
HOMEPAGE="http://www.netplex-tech.com/snips/"
SRC_URI="http://www.netplex-tech.com/software/downloads/${PN}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/perl
	 mail-client/mailx
	 net-analyzer/rrdtool
	 >=net-misc/iputils-20071127-r2
	 sys-libs/gdbm
	 sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Gentoo-specific non-interactive configure override
	cp "${FILESDIR}/${PF}-precache-config" "${S}/Config.cache"
	echo "CFLAGS=\"${CFLAGS} -fPIC\"" >> "${S}/Config.cache"
	echo "CC=\"$(tc-getCC)\"" >> "${S}/Config.cache"
	echo "SRCDIR=\"${S}\"" >> "${S}/Config.cache"
	epatch "${FILESDIR}/${P}-non-interactive.patch"
	# Applied to upstream CVS
	epatch "${FILESDIR}/${P}-implicit-declarations.patch"
	epatch "${FILESDIR}/${P}-conflicting-types.patch"
	epatch "${FILESDIR}/${P}-code-ordering.patch"
	epatch "${FILESDIR}/${P}-destdir-awareness.patch"
}

src_compile() {
	# Looks horrid due to missing linebreaks, suppress output
	ebegin "Running configure script (with precached settings)"
		./Configure &> /dev/null || die "Unable to configure"
	eend $?
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
