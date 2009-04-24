# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/stress/stress-1.0.0.ebuild,v 1.4 2009/04/24 04:56:49 darkside Exp $

inherit flag-o-matic

MY_P="${PN}-${PV/_/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Imposes stressful loads on different aspects of the system."
HOMEPAGE="http://weather.ou.edu/~apw/projects/stress"
SRC_URI="http://weather.ou.edu/~apw/projects/stress/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 ~sparc ~x86"
IUSE="static"

DEPEND="virtual/libc"

src_compile() {
	use static && append-ldflags -static
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog AUTHORS README
	# Upstream ships an empty file...
	rm -r ${D}/usr/share/man
}
