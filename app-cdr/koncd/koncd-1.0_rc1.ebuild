# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-cdr/koncd/koncd-1.0_rc1.ebuild,v 1.16 2002/08/16 02:31:09 murphy Exp $

inherit kde-base || die

need-kde 2.2

S=${WORKDIR}/koncd-1.0rc1
DESCRIPTION="A KDE frontend to cdr apps; very powerful"
SRC_URI="http://www.koncd.org/download/koncd-1.0rc1.tar.gz"
HOMEPAGE="http://www.koncd.org/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

newdepend "$DEPEND >=app-cdr/cdrtools-1.11 >=app-cdr/cdrdao-1.1.5 >=media-sound/mpg123-0.59r"


