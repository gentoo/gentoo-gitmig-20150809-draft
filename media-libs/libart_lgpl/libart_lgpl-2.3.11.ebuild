# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libart_lgpl/libart_lgpl-2.3.11.ebuild,v 1.1 2003/01/12 23:52:13 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a LGPL version of libart"
HOMEPAGE="http://www.levien.org/libart"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
