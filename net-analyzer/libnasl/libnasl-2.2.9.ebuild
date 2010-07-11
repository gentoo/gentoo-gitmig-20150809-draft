# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-2.2.9.ebuild,v 1.3 2010/07/11 03:43:28 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="=net-analyzer/nessus-libraries-${PV}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-openssl-1.patch
}

src_configure() {
	tc-export CC
	econf
}

src_compile() {
	# emake fails for >= -j2. bug #16471.
	emake -C nasl cflags || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
