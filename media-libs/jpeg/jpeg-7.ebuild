# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-7.ebuild,v 1.4 2009/08/23 00:52:55 vapier Exp $

EAPI="2"
inherit eutils libtool

DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="http://www.ijg.org/files/${PN}src.v${PV}.tar.gz
	mirror://gentoo/${P}-extra.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-maxmem_sysconf.patch
	elibtoolize

	# hook the extra dir into the normal jpeg build env
	mv ../${P}-extra extra
	sed -i '/all:/s:$:\n\t$(MAKE) -C extra $@:' Makefile.in
	# newer extra tarball has this integrated
	cd extra
	sed -e 's:mandir:man1dir:' Makefile > Makefile.in
	grep ' = @' ../Makefile.in >> Makefile.in
	printf 'all %%:\n\t../config.status --file=Makefile:Makefile.in\n\t$(MAKE) $@' > Makefile
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		--enable-static \
		--enable-maxmem=64
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc example.c README *.{log,txt}
}
