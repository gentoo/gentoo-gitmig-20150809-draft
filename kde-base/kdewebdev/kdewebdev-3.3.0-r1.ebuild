# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.3.0-r1.ebuild,v 1.2 2004/08/30 18:56:03 carlo Exp $

inherit kde-dist eutils

DESCRIPTION="KDE web development - Quanta"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="doc"
DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )
	!media-gfx/kimagemapeditor"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/3.3.0-kafka-configure.in.in.patch
	cd ${S} && make -f admin/Makefile.common
}
