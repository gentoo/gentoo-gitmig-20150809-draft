# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libart_lgpl/libart_lgpl-2.3.12.ebuild,v 1.3 2003/07/12 18:05:49 aliz Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a LGPL version of libart"
HOMEPAGE="http://www.levien.com/libart"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc alpha hppa"

DEPEND="dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

SCROLLKEEPER_UPDATE="0"
