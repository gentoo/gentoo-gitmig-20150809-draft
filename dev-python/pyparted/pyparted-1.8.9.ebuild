# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-1.8.9.ebuild,v 1.1 2007/08/21 23:30:21 wolf31o2 Exp $

inherit flag-o-matic

DESCRIPTION="Python bindings for parted"
HOMEPAGE="http://dcantrel.fedorapeople.org/pyparted/"
SRC_URI="http://dcantrel.fedorapeople.org/pyparted/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="sys-libs/ncurses"
IUSE=""

# Needed to build...
DEPEND="=dev-lang/python-2.4*
	>=sys-apps/parted-1.7.0
	>=app-arch/rpm-4"

src_compile() {
	useq debug && append-flags -O -ggdb -DDEBUG
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
}
