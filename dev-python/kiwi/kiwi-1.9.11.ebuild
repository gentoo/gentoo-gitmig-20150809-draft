# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kiwi/kiwi-1.9.11.ebuild,v 1.4 2007/02/07 22:30:17 pythonhead Exp $

inherit distutils versionator

DESCRIPTION="Kiwi is a pure Python framework and set of enhanced PyGTK widgets"
HOMEPAGE="http://www.async.com.br/projects/kiwi/"
SRC_URI="http://download.gnome.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3.5
	>=dev-python/pygtk-2.8"

src_unpack() {
	unpack ${A}
	sed -i "s:share/doc/kiwi:share/doc/${PF}:g" ${S}/setup.py || die "sed
	failed"
}
