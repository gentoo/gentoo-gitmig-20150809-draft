# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymtp/pymtp-0.0.4.ebuild,v 1.1 2009/05/06 17:58:59 ssuominen Exp $

inherit distutils multilib python

DESCRIPTION="libmtp bindings for python"
HOMEPAGE="http://nick125.com/projects/pymtp/"
SRC_URI="http://downloads.nick125.com/projects/pymtp/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libmtp-0.2.6"
DEPEND="${RDEPEND}"

pkg_postinst() {
	python_version	
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/pymtp.py
}

pkg_postrm() {
	python_mod_cleanup
}
