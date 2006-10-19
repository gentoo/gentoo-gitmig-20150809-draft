# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.2.3-r1.ebuild,v 1.2 2006/10/19 21:58:14 agriffis Exp $

inherit eutils flag-o-matic toolchain-funcs

STAMP=20060608
DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz
	mirror://gentoo/pci.ids-${STAMP}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/pcimodules-${PN}-2.2.0.patch

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
