# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libart_lgpl/libart_lgpl-2.3.10.ebuild,v 1.4 2002/08/14 13:08:09 murphy Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a LGPL version of libart"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.levien.org/libart"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
