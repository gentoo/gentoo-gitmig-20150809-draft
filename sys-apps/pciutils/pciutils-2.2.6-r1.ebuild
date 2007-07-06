# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.2.6-r1.ebuild,v 1.1 2007/07/06 05:09:40 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs multilib

DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="network-cron zlib"

DEPEND="zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.2.3-build.patch
	epatch "${FILESDIR}"/pcimodules-${PN}-2.2.6.patch
	epatch "${FILESDIR}"/${PN}-2.2.6-link.patch #160421
	epatch "${FILESDIR}"/${PN}-2.2.4-update-pciids.patch
	sed -i "/^LIBDIR=/s:/lib:/$(get_libdir):" Makefile
}

src_compile() {
	export ZLIB=$(use zlib && echo yes || echo no)
	tc-export AR CC RANLIB
	emake OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install install-lib DESTDIR="${D}" || die

	use network-cron || return 0
	exeinto /etc/cron.monthly
	newexe "${FILESDIR}"/pciutils.cron update-pciids || die
}

pkg_postinst() {
	cd "${ROOT}"/usr/share/misc
	rm -f pci.ids{,.gz}.old
	use zlib && rm -f pci.ids || rm -f pci.ids.gz
}
