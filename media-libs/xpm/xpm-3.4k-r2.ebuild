# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xpm/xpm-3.4k-r2.ebuild,v 1.9 2004/04/03 23:39:03 spyderous Exp $

# Note that this is a dummy package.  It's just a placeholder.  If the
# package which needs xpm needs X11, it doesn't need xpm, because X11
# provides xpm.  This placeholder is only here if it is a non-X package
# which needs xpm,  If this does become non-dummy, it needs to provide a
# virtual/xpm -- to be revisited

DESCRIPTION="xpm is provided by X11"
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="virtual/x11"
