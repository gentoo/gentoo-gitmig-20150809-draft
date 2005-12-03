# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgc/libgc-6.6.ebuild,v 1.1 2005/12/03 00:37:52 vapier Exp $

DESCRIPTION="A garbage collector for C and C++"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/gc${PV}

src_install() {
	make DESTDIR="${D}" install || die
	cd "${D}"/usr/share
	dohtml gc/*.html
	newman gc/gc.man gc.1L
	dodoc gc/README*
	rm -r gc
}
