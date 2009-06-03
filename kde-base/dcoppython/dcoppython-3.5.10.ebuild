# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcoppython/dcoppython-3.5.10.ebuild,v 1.5 2009/06/03 15:38:05 ranger Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE: Python bindings for DCOP"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ppc64 ~sparc ~x86"
IUSE=""
DEPEND="virtual/python"
RDEPEND="${DEPEND}"

# Because this installs into /usr/lib/python2.3/..., it doesn't have SLOT=X.Y like the rest of KDE,
# and it installs into /usr entirely
SLOT="0"

PATCHES=( "$FILESDIR/no-gtk-glib-check.diff"
	 "${FILESDIR}/${P}-python-2.6.patch"
	 "${FILESDIR}/${P}-python2.6-configure.patch" )

src_compile() {
	myconf="${myconf} --prefix=/usr"
	kde_src_compile
}
