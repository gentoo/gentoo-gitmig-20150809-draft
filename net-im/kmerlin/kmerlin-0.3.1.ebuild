# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-0.3.1.ebuild,v 1.10 2002/02/09 11:47:57 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1
SLOT="0"
DESCRIPTION="KDE MSN Messenger"
SRC_URI="http://prdownloads.sourceforge.net/kmsn/kmerlin-0.3.1.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"
