# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gpixpod/gpixpod-0.6.2.ebuild,v 1.8 2011/01/12 15:18:30 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit distutils

DESCRIPTION="Organize photos on your iPod, freely!"
HOMEPAGE="http://www.gpixpod.org/"
SRC_URI="mirror://sourceforge/gpixpod/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.8.4
		>=x11-libs/gtk+-2.0.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PYTHON_MODNAME="gpixpod.py gpixpod_cli.py ipodhal.py mh.py utils.py"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Fixing gpixpod.py for searching gpixpod.glade in the same directory
	sed -i -e "s:gpixpod\.glade:/usr/share/gpixpod/gpixpod\.glade:g" gpixpod.py || die

	# Fixing launching script and Makefile
	sed -i -e "s:python2.4:$(PYTHON):g" Makefile gpixpod || die
	sed -i -e "s:/usr/lib/gpixpod:$(python_get_sitedir):g" gpixpod || die
}

src_install() {
	distutils_src_install

	mv "${D}"/usr/lib/gpixpod/* "${D}"/usr/share/gpixpod
	rmdir "${D}"/usr/lib/gpixpod

	rm -rf "${D}"/usr/share/doc/gpixpod
	dodoc KNOWNBUGS
}
