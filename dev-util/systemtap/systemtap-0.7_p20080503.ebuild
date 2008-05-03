# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/systemtap/systemtap-0.7_p20080503.ebuild,v 1.1 2008/05/03 16:47:59 swegener Exp $

inherit linux-info eutils

DESCRIPTION="A linux trace/probe tool"
HOMEPAGE="http://sourceware.org/systemtap/"
if [[ ${PV} = *_p* ]] # is this a snaphot?
then
	SRC_URI="ftp://sources.redhat.com/pub/${PN}/snapshots/${PN}-${PV/*_p/}.tar.bz2"
else
	die "Sorry, currently there are only snapshots available." # but they have an internal version (see configure.ac)
fi

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

	epatch "${FILESDIR}"/systemtap-20080119-grsecurity.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog HACKING NEWS README
}

pkg_postinst() {
	elog "If you use a kernel patched with grsecurity (e.g. sys-kernel/hardened-sources)"
	elog "then please append '-D HAVE_GRSECURITY' to your stap command line."
}
