# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-6.3-r1.ebuild,v 1.6 2004/10/19 08:25:39 absinthe Exp $

MY_P=gc${PV/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc alpha ppc amd64 hppa ~macos ~ppc64 ppc-macos ~ia64"
IUSE="c++"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e '/^SUBDIRS/s/doc//' Makefile.in || die
}

src_compile() {
	econf \
		`use_enable c++ cplusplus` \
		--enable-threads=pthreads || die "Configure failed..."
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# dist_noinst_HEADERS
	insinto /usr/include/gc
	doins include/{cord.h,ec.h,javaxfc.h}
	insinto /usr/include/gc/private
	doins include/private/*.h

	dodoc README.QUICK doc/README* doc/barrett_diagram
	dohtml doc/*.html
	newman doc/gc.man gc.1
}
