# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libart_lgpl/libart_lgpl-2.3.9.ebuild,v 1.1 2002/06/26 06:32:58 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a LGPL version of libart"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.levien.org/libart"
LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND} dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"


