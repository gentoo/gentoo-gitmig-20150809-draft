# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.2.0-r1.ebuild,v 1.14 2006/04/18 17:05:48 flameeyes Exp $

inherit eutils flag-o-matic toolchain-funcs

STAMP=20051015
DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz
	mirror://gentoo/pci.ids-${STAMP}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/pcimodules-${P}.patch
	epatch "${FILESDIR}"/${P}-shared-lib.patch
	epatch "${FILESDIR}"/${PN}-2.1.11-malloc.patch

	# Set Gentoo paths
	# and do not strip (breaks cross-compile), portage handles stripping
	sed -i \
		-e '/^PREFIX=/s:=.*:=/usr:' \
		-e '/^IDSDIR=/s:=.*:=$(PREFIX)/share/misc:' \
		-e '/INSTALL.* -s lspci /s: -s lspci : lspci :' \
		Makefile || die

	# Make sure we respect $AR / $RANLIB
	sed -i \
		-e '/ar rcs/s:ar:$(AR):' \
		-e 's:ranlib:$(RANLIB):' \
		lib/Makefile \
		|| die "sed lib/Makefile failed"

	sed -i 's:wget -O:wget --connect-timeout=60 -O:' update-pciids.sh
	ebegin "Updating pci.ids from the web"
	if ! ./update-pciids.sh &> /dev/null ; then
		# if we cant update, use a cached version
		mv "${WORKDIR}"/pci.ids-${STAMP} "${S}"/pci.ids
	fi
	eend 0
}

src_compile() {
	tc-export AR CC RANLIB
	emake OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/share/man
	make install PREFIX="${D}"/usr || die

	dolib lib/libpci.* || die "libpci failed"
	insinto /usr/include/pci
	doins lib/{config,header,pci,types}.h || die "headers failed"
}
