# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.03_beta1-r1.ebuild,v 1.2 2002/07/01 21:33:31 danarmak Exp $
inherit kde-base || die

need-kde 3

LICENSE="GPL-2"
DESCRIPTION="An oldschool Filemanager for KDE"
HOMEPAGE="http:/krusader.sourceforge.net/"

P=`echo ${P}|sed 's/_/-/g'`
SRC_URI="http://krusader.sourceforge.net/dev/${P}.tar.gz"
S=${WORKDIR}/${P}

