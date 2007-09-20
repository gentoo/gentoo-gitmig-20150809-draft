# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-1.8.9.ebuild,v 1.3 2007/09/20 20:09:47 wolf31o2 Exp $

inherit multilib

DESCRIPTION="Python bindings for parted"
HOMEPAGE="http://dcantrel.fedorapeople.org/pyparted/"
SRC_URI="http://dcantrel.fedorapeople.org/pyparted/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	>=dev-lang/python-2.4
	>=sys-apps/parted-1.7.0"

src_compile() {
	sed -i "s/\$(shell rpm --eval \"%{_libdir}\")/usr\/$(get_libdir)/" Makefile || die "cannot fix libdir"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
}
