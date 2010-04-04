# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-3.1.ebuild,v 1.3 2010/04/04 15:55:44 armin76 Exp $

EAPI="2"

inherit autotools multilib python

DESCRIPTION="Python bindings for sys-apps/parted"
HOMEPAGE="https://fedorahosted.org/pyparted/"
SRC_URI="https://fedorahosted.org/releases/p/y/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="
	sys-libs/ncurses
	>=dev-lang/python-2.4
	>=sys-apps/parted-2.1
	dev-python/decorator
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/-avoid-version/& -shared /' src/Makefile.am || die "sed failed"
	eautoreconf
}

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog NEWS README TODO
	# remove pointless libtool archive
	python_version
	rm -f "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/_pedmodule.la

}
