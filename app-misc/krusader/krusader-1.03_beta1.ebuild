# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.03_beta1.ebuild,v 1.1 2002/06/10 18:20:19 wmertens Exp $
inherit kde-base || die

need-kde 3

DESCRIPTION="An oldschool Filemanager for KDE"
HOMEPAGE="http:/krusader.sourceforge.net/"

SRC_URI="http://krusader.sourceforge.net/dev/${P}.tar.gz"

P=`echo ${P}|sed 's/_/-/g'`
S=${WORKDIR}/${P}

