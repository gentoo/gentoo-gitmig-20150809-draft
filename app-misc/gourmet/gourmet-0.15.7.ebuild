# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gourmet/gourmet-0.15.7.ebuild,v 1.1 2011/01/29 02:54:56 nixphoeni Exp $

EAPI="2"
PYTHON_DEPEND="2:2.4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils python

DESCRIPTION="Recipe Organizer and Shopping List Generator for Gnome"
HOMEPAGE="http://grecipe-manager.sourceforge.net/"
SRC_URI="mirror://sourceforge/grecipe-manager/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-print pdf rtf"

# I wish there were a better way to check if the current Python version
# was built with the 'sqlite' use flag and, if it wasn't, pull in pysqlite,
# but I'm not sure how.
RDEPEND=">=dev-python/pygtk-2.3.93
	>=dev-python/libgnome-python-2
	>=gnome-base/libglade-2
	|| ( =dev-lang/python-2*[sqlite] dev-python/pysqlite:2 )
	<dev-python/sqlalchemy-0.6.4
	dev-python/imaging
	dev-python/gtkspell-python
	dev-db/metakit[python]
	pdf? ( dev-python/reportlab dev-python/python-poppler )
	rtf? ( dev-python/pyrtf )
	gnome-print? ( >=dev-python/libgnomeprint-python-2
	               dev-python/python-poppler )"
DEPEND="${RDEPEND}"

RESTRICT_PYTHON_ABIS="3.*"

# distutils gets a bunch of default docs
DOCS="TESTS FAQ"

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs -r --quiet 2 .
}

src_install() {
	distutils_src_install --disable-modules-check
	doman gourmet.1
}
