# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <bart.verwilst@pandora.be>
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-2.0.1-r1.ebuild,v 1.4 2001/10/03 09:54:07 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="KDevelop ${PV}"
HOMEPAGE="www.kdevelop.org"

SRC_PATH="kde/stable/2.2.1/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

DEPEND="$DEPEND
	>=kde-base/kdelibs-2.2
	sys-devel/flex
	sys-devel/perl
	>=kde-base/kdoc-2.2.1
	>=dev-util/kdbg-1.2.1"

RDEPEND="$RDEPEND
	>=kde-base/kdelibs-2.2
	>=kde-base/kdoc-2.2.1
	>=dev-util/kdbg-1.2.1"
