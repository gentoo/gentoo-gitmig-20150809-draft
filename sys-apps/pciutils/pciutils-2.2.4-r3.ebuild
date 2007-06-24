# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.2.4-r3.ebuild,v 1.12 2007/06/24 20:14:30 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE="hal network-cron zlib"

DEPEND="zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.2.3-build.patch
	epatch "${FILESDIR}"/pcimodules-${PN}-2.2.4.patch
	epatch "${FILESDIR}"/${P}-link.patch #160421
	epatch "${FILESDIR}"/${P}-update-pciids.patch
}

src_compile() {
	export ZLIB=$(use zlib && echo yes || echo no)
	tc-export AR CC RANLIB
	emake OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die

	dolib lib/libpci.* || die "libpci failed"
	insinto /usr/include/pci
	doins lib/{config,header,pci,types}.h || die "headers failed"

	if use hal ; then
		# hack around pci-ids because hal sucks
		sed -i \
			-e '/^DEST=/s:.gz$::' \
			-e '/^PCI_COMPRESSED_IDS=/s:=.*:=:' \
			"${D}"/usr/sbin/update-pciids
		cd "${D}"/usr/share/misc
		gunzip pci.ids.gz || die
	fi

	use network-cron || return 0
	exeinto /etc/cron.monthly
	newexe "${FILESDIR}"/pciutils.cron update-pciids || die
}

pkg_postinst() {
	use hal || return 0
	# hack around pci-ids because hal sucks
	cd "${ROOT}"/usr/share/misc
	rm -f pci.ids.gz{,.old}
}
