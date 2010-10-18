# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sexy-python/sexy-python-0.1.9-r1.ebuild,v 1.10 2010/10/18 13:50:06 armin76 Exp $

EAPI="3"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
SUPPORT_PYTHON_ABIS="1"

inherit python

DESCRIPTION="Python bindings for libsexy."
HOMEPAGE="http://www.chipx86.com/wiki/Libsexy"
SRC_URI="http://releases.chipx86.com/libsexy/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libsexy-${PV}
	>=dev-python/pygtk-2.6.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc AUTHORS ChangeLog NEWS README
}
