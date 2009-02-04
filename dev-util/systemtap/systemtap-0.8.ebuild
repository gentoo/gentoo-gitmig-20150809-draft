# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/systemtap/systemtap-0.8.ebuild,v 1.2 2009/02/04 22:29:26 swegener Exp $

inherit linux-info eutils

DESCRIPTION="A linux trace/probe tool"
HOMEPAGE="http://sourceware.org/systemtap/"
if [[ ${PV} = *_pre* ]] # is this a snaphot?
then
	# see configure.ac to get the version of the snapshot
	SRC_URI="http://sources.redhat.com/${PN}/ftp/snapshots/${PN}-${PV/*_pre/}.tar.bz2
		mirror://gentoo/${PN}-${PV/*_pre/}.tar.bz2" # upstream only keeps four snapshot distfiles around
	S="${WORKDIR}"/src
else
	SRC_URI="http://sources.redhat.com/${PN}/ftp/releases/${P}.tar.gz"
	# use default S for releases
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite"

DEPEND=">=dev-libs/elfutils-0.131
	sys-libs/libcap
	sqlite? ( =dev-db/sqlite-3* )"
RDEPEND="${DEPEND}
	virtual/linux-sources"

CONFIG_CHECK="KPROBES ~RELAY ~DEBUG_FS"
ERROR_KPROBES="${PN} requires support for KProbes Instrumentation (KPROBES) - this can be enabled in 'Instrumentation Support -> Kprobes'."
ERROR_RELAY="${PN} works with support for user space relay support (RELAY) - this can be enabled in 'General setup -> Kernel->user space relay support (formerly relayfs)'."
ERROR_DEBUG_FS="${PN} works best with support for Debug Filesystem (DEBUG_FS) - this can be enabled in 'Kernel hacking -> Debug Filesystem'."

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/systemtap-20080119-grsecurity.patch
	epatch "${FILESDIR}"/${P}-gcc-4.3.3-warnings.patch
}

src_compile() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable sqlite) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog HACKING NEWS README
}

pkg_postinst() {
	elog "If you use a kernel patched with grsecurity (e.g. sys-kernel/hardened-sources)"
	elog "then please append '-D HAVE_GRSECURITY' to your stap command line."
}
