# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xpm/xpm-3.4k-r2.ebuild,v 1.8 2004/02/20 10:38:05 mr_bones_ Exp $

# Note that this is a dummy package.  It's just a placeholder.  If the
# package which needs xpm needs xfree, it doesn't need xpm, because xfree
# provides xpm.  This placeholder is only here if it is a non-X package
# which needs xpm,  If this does become non-dummy, it needs to provide a
# virtual/xpm -- to be revisited

DESCRIPTION="xpm is provided by xfree"
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="virtual/x11"
