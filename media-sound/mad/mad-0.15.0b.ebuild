# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mad/mad-0.15.0b.ebuild,v 1.3 2004/01/01 15:25:39 mholzer Exp $

IUSE=""

S=${WORKDIR}/${P}

HOMEPAGE="http://mad.sourceforge.net/"
DESCRIPTION="The MAD metapackage for libmad, libid3tag, and madplay"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~mips"

DEPEND="~media-libs/libmad-${PV}
	~media-libs/libid3tag-${PV}
	~media-sound/madplay-${PV}"
