# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdoc/kdoc-2.0_alpha54.ebuild,v 1.3 2002/07/23 11:22:19 seemant Exp $

MY_P=${P/_alph/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="KDE/QT documentation processing/generation tools"
HOMEPAGE="http://www.ph.unimelb.edu.au/~ssk/kde/kdoc/"
SRC_PATH="kde/stable/3.0/src/${MY_P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	ftp://download.us.kde.org/pub/kde/$SRC_PATH
	ftp://download.uk.kde.org/pub/kde/$SRC_PATH
	ftp://download.au.kde.org/pub/kde/$SRC_PATH
	ftp://download.at.kde.org/pub/kde/$SRC_PATH
	ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-devel/perl"

src_compile() {

	export KDEDIR=""
	export QTDIR=""
	./configure --prefix=/usr || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	
}
