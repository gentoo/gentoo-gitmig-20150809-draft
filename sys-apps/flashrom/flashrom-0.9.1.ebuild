# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/flashrom/flashrom-0.9.1.ebuild,v 1.1 2010/01/28 20:04:28 idl0r Exp $

EAPI="2"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Utility for reading, writing, erasing and verifying flash ROM chips"
HOMEPAGE="http://flashrom.org"
SRC_URI="http://qa.coreboot.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ftdi serprog"

RDEPEND="sys-apps/pciutils
	ftdi? ( dev-embedded/libftdi )"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_prepare() {
	# We don't need zlib here
	# Disable auto-deps
	sed -i -e 's:^LIBS +=.*:LIBS += -lpci:' \
		-e 's/^all:.*/all: dep $(PROGRAM)/' \
		-e 's/^\.features:.*/\.features:/' \
		Makefile || die
}

src_compile() {
	if use ftdi;
	then
		append-cflags "-DFT2232_SPI_SUPPORT=1"
		export LIBS="-lftdi"
	fi
	if use serprog;
	then
		append-cflags "-DSERPROG_SUPPORT=1"
	fi

	# Get a rid of "grep: .features: No such file or directory" warnings
	touch .features

	emake CC="$(tc-getCC)" STRIP="" || die "emake failed"
}

src_install() {
	dosbin flashrom || die
	doman flashrom.8 || die
	dodoc ChangeLog README
}
