# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

S="${WORKDIR}/kmerlin-0.3.3"
need-kde 2.1
SLOT="0"
DESCRIPTION="KDE MSN Messenger"
SRC_URI="http://prdownloads.sourceforge.net/kmsn/kmerlin-0.3.3.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"
