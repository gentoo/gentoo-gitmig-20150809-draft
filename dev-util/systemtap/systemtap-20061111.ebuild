# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/systemtap/systemtap-20061111.ebuild,v 1.1 2006/11/18 00:02:08 genstef Exp $

inherit linux-info

DESCRIPTION="A linux trace/probe tool"
HOMEPAGE="http://sourceware.org/systemtap/"
SRC_URI="ftp://sources.redhat.com/pub/${PN}/snapshots/${P}.tar.bz2"
S=${WORKDIR}/src

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/elfutils-0.116"
RDEPEND="${DEPEND}"

CONFIG_CHECK="KPROBES RELAY"
ERROR_KPROBES="${PN} requires support for KProbes Instrumentation (KPROBES) - this can be enabled in 'Instrumentation Support -> Kprobes'."
ERROR_RELAY="${PN} requires support for kernel to user space relay support (RELAY) - this can be enabled in 'General setup -> Kernel->user space relay support (formerly relayfs)'."

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	keepdir /var/cache/systemtap
	dodoc AUTHORS ChangeLog HACKING NEWS README
}
