# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libart_lgpl/libart_lgpl-2.3.10.ebuild,v 1.6 2002/09/21 11:49:09 bjb Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a LGPL version of libart"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.levien.org/libart"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
