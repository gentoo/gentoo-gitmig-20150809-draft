# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-3.0.ebuild,v 1.1 2010/01/24 17:00:24 jer Exp $

EAPI="2"

inherit multilib python

DESCRIPTION="Python bindings for sys-apps/parted"
HOMEPAGE="https://fedorahosted.org/pyparted/"
SRC_URI="http://fedorahosted.org/releases/p/y/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND="
	sys-libs/ncurses
	>=dev-lang/python-2.4
	>=sys-apps/parted-2.1
	dev-python/decorator
"
RDEPEND="${DEPEND}"

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog NEWS README TODO
}
