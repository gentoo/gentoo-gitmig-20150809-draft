# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-1.8.9-r1.ebuild,v 1.1 2010/01/07 20:53:53 jer Exp $

inherit multilib python toolchain-funcs

DESCRIPTION="Python bindings for parted"
HOMEPAGE="https://fedorahosted.org/pyparted/"
SRC_URI="https://fedorahosted.org/releases/p/y/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	>=dev-lang/python-2.4
	>=sys-apps/parted-1.7.0"

src_compile() {
	sed -i \
		"s/\$(shell rpm --eval \"%{_libdir}\")/usr\/$(get_libdir)/" \
		Makefile || die "cannot fix libdir"
	emake CC=$(tc-getCC) || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
	python_need_rebuild
}
