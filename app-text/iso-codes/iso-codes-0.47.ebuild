# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/iso-codes/iso-codes-0.47.ebuild,v 1.1 2005/08/19 19:58:53 joem Exp $

DESCRIPTION="his package provides the ISO-639 Language code list, the ISO-3166
Territory code list, and ISO-3166-2 sub-territory lists, and all their
translations in gettext .po form"
HOMEPAGE="http://alioth.debian.org/projects/pkg-isocodes/"
SRC_URI="http://ftp.debian.org/debian/pool/main/i/iso-codes/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-devel/gettext
		>=dev-lang/python-2.3
		>=dev-python/pyxml-0.8.4
		>=sys-devel/automake-1.9"

src_install()
{
	make DESTDIR=${D} install || die "install failed"
}
