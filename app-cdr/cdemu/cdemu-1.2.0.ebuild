# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-1.2.0.ebuild,v 1.2 2010/01/16 17:39:14 fauli Exp $

EAPI="2"

NEED_PYTHON="2.4"
inherit multilib python

DESCRIPTION="Client of cdemu suite, which mounts all kinds of cd images"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-client-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	~app-cdr/cdemud-${PV}"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21"

S=${WORKDIR}/cdemu-client-${PV}

src_prepare() {
	# disable compilation of python modules
	rm py-compile && \
	ln -s "$(type -P true)" py-compile || die
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	python_mod_optimize "$(python_get_sitedir)/cdemu"
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup "/usr/$(get_libdir)/python*/site-packages/cdemu"
}
