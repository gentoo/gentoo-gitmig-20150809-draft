# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libart_lgpl/libart_lgpl-2.3.16.ebuild,v 1.9 2003/12/28 12:41:54 spider Exp $

inherit gnome2

DESCRIPTION="a LGPL version of libart"
HOMEPAGE="http://www.levien.com/libart"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="ia64 x86 ppc sparc alpha hppa amd64"

DEPEND="dev-util/pkgconfig"
RDEPEND="virtual/glibc"
# Add the RDEPEND so we dont have a runtime dep on pkg-config

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
