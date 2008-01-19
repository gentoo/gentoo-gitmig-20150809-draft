# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnomecatalog/gnomecatalog-0.3.3.ebuild,v 1.2 2008/01/19 21:47:24 mr_bones_ Exp $

inherit python distutils

DESCRIPTION="Cataloging software for CDs and DVDs."
HOMEPAGE="http://gnomecatalog.sf.net/"
SRC_URI="http://launchpadlibrarian.net/11326737/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-python/pygtk-2.3.96
	dev-python/pyvorbis
	dev-python/pysqlite
	dev-python/gnome-python
	dev-python/kaa-metadata"

S=${WORKDIR}/${P}.orig
