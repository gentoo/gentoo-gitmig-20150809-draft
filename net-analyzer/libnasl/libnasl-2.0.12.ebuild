# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-2.0.12.ebuild,v 1.3 2004/07/24 02:38:29 weeve Exp $

inherit eutils

DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64"
IUSE=""

DEPEND="=net-analyzer/nessus-libraries-${PV}"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "configuration failed"
	# emake fails for >= -j2. bug #16471.
	make || die "make failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "Install failed libnasl"
	dodoc COPYING TODO
}
