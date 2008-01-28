# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccmalloc/ccmalloc-0.4.0.ebuild,v 1.2 2008/01/28 00:55:11 hawking Exp $

inherit eutils

DESCRIPTION="A easy-to-use memory debugging library"
HOMEPAGE="http://www.inf.ethz.ch/personal/biere/projects/ccmalloc/"
SRC_URI="http://www.inf.ethz.ch/personal/biere/projects/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug"
DEPEND="sys-devel/gcc sys-apps/sed"
RDEPEND="virtual/libc"

src_compile() {
	local myconf
	use debug && ${myconf} = "${myconf} --debug"
	./configure --prefix=/usr ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall PREFIX="${D}"/usr || die "einstall failed"
	dodoc BUGS FEATURES NEWS README TODO USAGE VERSION
}
