# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-2.0.1-r2.ebuild,v 1.3 2001/11/16 12:50:41 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.2

DESCRIPTION="KDevelop ${PV}"
HOMEPAGE="www.kdevelop.org"

SRC_PATH="kde/stable/2.2.1/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

DEPEND="$DEPEND
	>=kde-base/kdebase-2.2
	sys-devel/flex
	sys-devel/perl
	>=kde-base/kdoc-2.2.1
	>=dev-util/kdbg-1.2.1
	>=net-www/htdig-3.1.5
	>=app-text/enscript-1.6.1
	>=app-text/a2ps-4.13b
	>=dev-util/ctags-5.0.1
	>=app-text/sgmltools-lite-3.0.3"

RDEPEND="$RDEPEND
	>=kde-base/kdoc-2.2.1
	>=dev-util/kdbg-1.2.1
        >=net-www/htdig-3.1.5
        >=app-text/enscript-1.6.1
        >=app-text/a2ps-4.13b
        >=dev-util/ctags-5.0.1
	>=app-text/sgmltools-lite-3.0.3"
