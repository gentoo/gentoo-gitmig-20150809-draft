# Copyright 2003 Gentoo Technologies, Inc.
# Distruibuted under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/media-libs/xpm/xpm-3.4k-r2.ebuild,v 1.3 2003/06/13 00:22:03 seemant Exp $

# Note that this is a dummy package.  It's just a placeholder.  If the
# package which needs xpm needs xfree, it doesn't need xpm, because xfree
# provides xpm.  This placeholder is only here if it is a non-X package
# which needs spm,  If this does become non-dummy, it needs to provide a
# virtual/xpm -- to be revisited

DESCRIPTION="xpm is provided by xfree. This is a dummy"
HOMEPAGE="http://www.gentoo.org/"


SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"
LICENSE="GPL-2"

RDEPEND="virtual/x11"
