# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /home/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-0.3.1.ebuild,v 1.1
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.1
need-qt 2.2

S=${WORKDIR}/${P}
DESCRIPTION="KMerlin 0.3.1"
SRC_URI="http://prdownloads.sourceforge.net/kmsn/kmerlin-0.3.1.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"
