# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/systemtap/systemtap-20070901.ebuild,v 1.1 2007/09/02 20:26:16 swegener Exp $

inherit linux-info eutils

DESCRIPTION="A linux trace/probe tool"
HOMEPAGE="http://sourceware.org/systemtap/"
SRC_URI="ftp://sources.redhat.com/pub/${PN}/snapshots/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/elfutils-0.122
	sys-libs/libcap
	=dev-db/sqlite-3*"
RDEPEND="${DEPEND}
	virtual/linux-sources"

S="${WORKDIR}"/src

CONFIG_CHECK="KPROBES ~RELAY ~DEBUG_FS"
ERROR_KPROBES="${PN} requires support for KProbes Instrumentation (KPROBES) - this can be enabled in 'Instrumentation Support -> Kprobes'."
ERROR_RELAY="${PN} works with support for user space relay support (RELAY) - this can be enabled in 'General setup -> Kernel->user space relay support (formerly relayfs)'."
ERROR_DEBUG_FS="${PN} works best with support for Debug Filesystem (DEBUG_FS) - this can be enabled in 'Kernel hacking -> Debug Filesystem'."

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/systemtap-20070414-grsecurity.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog HACKING NEWS README
}

pkg_postinst() {
	elog "If you use a kernel patched with grsecurity (e.g. sys-kernel/hardened-sources)"
	elog "then please append '-D HAVE_GRSECURITY' to your stap command line."
}
