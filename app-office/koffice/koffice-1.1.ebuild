# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.1.ebuild,v 1.3 2001/10/02 23:54:52 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="KDE ${PV} - KOffice"

HOMEPAGE="http://www.koffice.org/"

# turns out kde.org.eclass doesn't work here
SRC_PATH="kde/stable/${P}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

DEPEND="$DEPEND
	>=kde-base/kdelibs-2.2
	>=dev-lang/python-2.0-r4"
#	>=sys-devel/automake-1.4
#	>=sys-devel/autoconf-1.13"
	# hm. This was in achim's original. are these versions superior to the ones we have by default in a current-day rc6?

RDEPEND="$RDEPEND
	>=kde-base/kdelibs-2.2"

src_unpack() {
	base_src_unpack all patch
}
