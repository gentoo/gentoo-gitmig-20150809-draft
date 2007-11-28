# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmp/jmp-0.51.ebuild,v 1.6 2007/11/28 03:18:04 betelgeuse Exp $

inherit java-pkg-2

DESCRIPTION="Java Memory Profiler"
HOMEPAGE="http://www.khelekore.org/jmp/"

# From the upstream maintainer:
# Yes, old OpenBSD server that does not like the window scaling
# that modern linuxes uses.
# Try something like this:
# $ sudo bash
# $ echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
#
#SRC_URI="http://www.khelekore.org/${PN}/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

IUSE="gtk"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

# Fails to detect >sun-jdk-1.5 as a valid jdk
RDEPEND="|| ( =virtual/jre-1.5* =virtual/jre-1.4* )
	gtk? ( >=x11-libs/gtk+-2.0 )"
DEPEND="|| ( =virtual/jdk-1.5* =virtual/jdk-1.4* )
	${RDEPEND}"

src_compile() {
	econf $(use_enable !gtk noui) || die "econf ${myconf} failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"
	dodoc ChangeLog README TODO || die
}

pkg_postinst() {
	elog "Please not that jmp is not compatible with VMs newer"
	elog "than 1.5 so make sure your vm is set to either 1.4 or"
	elog "1.5 when using jmp with the vm."
}
