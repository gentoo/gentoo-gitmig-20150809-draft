# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmgtemp/wmgtemp-0.6.ebuild,v 1.1 2002/10/07 16:24:05 raker Exp $

IUSE=""

S="${WORKDIR}/${PN}"

DESCRIPTION="CPU and SYS temperature dockapp"
HOMEPAGE="http://www.fluxcode.net"
SRC_URI="http://www.fluxcode.net/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="sys-apps/lm_sensors"
RDEPEND="${DEPEND}"

src_compile() {

	# Set compile optimizations
	cd ${S}/src
	cp Makefile Makefile.orig
	sed -e "s:-Wall -g:\$(CFLAGS):" \
		Makefile.orig > Makefile

	emake || die "parallel make failed"

}

src_install() {

	cd ${S}
	dodoc BUGS CREDITS INSTALL README TODO

	cd ${S}/src
	dobin wmgtemp

}
