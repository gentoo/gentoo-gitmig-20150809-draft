# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-2.1-r1.ebuild,v 1.1 2002/04/17 19:41:10 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base

need-kde 3

S=${WORKDIR}/${P}_for_KDE_3.0

DESCRIPTION="KDevelop ${PV}"
HOMEPAGE="www.kdevelop.org"

SRC_PATH="kde/stable/3.0/src/${P}_for_KDE_3.0.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

DEPEND="$DEPEND
	sys-devel/flex
	sys-devel/perl"

newdepend ">=kde-base/kdebase-3
	>=dev-util/kdoc-2.0_alpha24
	>=dev-util/kdbg-1.2.5.3
        app-misc/glimpse
	>=app-text/enscript-1.6.1
        >=app-text/a2ps-4.13b
        >=dev-util/ctags-5.0.1
	>=app-text/sgmltools-lite-3.0.3
	>=app-doc/qt-docs-${QTVER}"
