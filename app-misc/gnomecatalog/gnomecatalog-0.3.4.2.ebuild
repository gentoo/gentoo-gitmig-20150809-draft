# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnomecatalog/gnomecatalog-0.3.4.2.ebuild,v 1.1 2009/03/22 14:27:47 eva Exp $

EAPI="2"

inherit eutils python distutils

DESCRIPTION="Cataloging software for CDs and DVDs."
HOMEPAGE="http://gnomecatalog.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	dev-python/pyvorbis
	>=dev-lang/python-2.5
	dev-python/pysqlite:2
	|| (
		>=dev-lang/python-2.5[xml]
		dev-python/pyxml )
	dev-python/kaa-metadata

	dev-python/gconf-python
	dev-python/libgnome-python
	dev-python/gnome-vfs-python
	dev-python/pygobject
	>=dev-python/pygtk-2.4"
DEPEND="${RDEPEND}"

src_prepare() {
	# Fix importing from a single folder in /media
	epatch "${FILESDIR}/${P}-dbus.patch"
}
