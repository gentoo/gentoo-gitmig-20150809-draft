# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-3.6-r1.ebuild,v 1.1 2008/10/26 23:44:03 hawking Exp $

EAPI="2"
inherit python multilib distutils

DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://auriga.wearlab.de/~alb/msnlib/"
SRC_URI="http://auriga.wearlab.de/~alb/msnlib/files/${PV}/${P}.tar.bz2"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="tk"

DEPEND=">=dev-lang/python-2.2.2[tk?]"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	dodoc doc/* || die "dodoc failed."
	dobin msn
	dobin msnsetup
	use tk && dobin utils/msntk

	insinto /usr/share/doc/${PF}
	doins msnrc.sample
}

pkg_postinst() {
	local module
	python_version
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/msn{cb,lib}.py
}

pkg_postrm() {
	python_mod_cleanup
}
