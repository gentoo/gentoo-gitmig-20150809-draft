# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-2.0.2.ebuild,v 1.6 2002/05/21 18:14:08 danarmak Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="KDevelop ${PV}"
HOMEPAGE="www.kdevelop.org"

SRC_PATH="kde/stable/2.2.2/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

DEPEND="$DEPEND
	sys-devel/flex
	sys-devel/perl"

newdepend ">=kde-base/kdebase-2.2
	>=dev-util/kdoc-2.0_alpha23
	>=dev-util/kdbg-1.2.1
        >=net-www/htdig-3.1.5
        >=app-text/enscript-1.6.1
        >=app-text/a2ps-4.13b
        >=dev-util/ctags-5.0.1
	>=app-text/sgmltools-lite-3.0.3
	=app-doc/qt-docs-2*"
