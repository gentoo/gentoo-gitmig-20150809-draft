# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/kxicq2/kxicq2-0.7.ebuild,v 1.1 2001/11/25 19:54:00 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.1
need-qt 2.1

S="${WORKDIR}/kxicq2-0.7.b2"
SRC_URI="http://download.sourceforge.net/kxicq/kxicq2-0.7.b2.tar.gz"

HOMEPAGE="http://www.kxicq.org"
DESCRIPTION="KDE 2.x ICQ Client"

src_unpack() {

	base_src_unpack
	kde-objprelink-patch

}

