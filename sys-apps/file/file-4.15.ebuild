# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.15.ebuild,v 1.2 2005/08/19 16:08:57 vapier Exp $

inherit distutils libtool

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="python build"

DEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"

	uclibctoolize

	# make sure python links against the current libmagic #54401
	sed -i "/library_dirs/s:'\.\./src':'../src/.libs':" python/setup.py

	# dont let python README kill main README #60043
	mv python/README{,.python}
}

src_compile() {
	econf --datadir=/usr/share/misc || die
	emake || die "emake failed"

	use build && return 0
	use python && cd python && distutils_src_compile
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	if ! use build ; then
		dodoc ChangeLog MAINT README
		use python && cd python && distutils_src_install
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
