# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdlabel/kcdlabel-2.12-r1.ebuild,v 1.6 2007/02/05 10:33:44 flameeyes Exp $

inherit flag-o-matic kde eutils

S=${WORKDIR}/${P}-KDE3

DESCRIPTION="cd label printing tool for kde"
HOMEPAGE="http://kcdlabel.sourceforge.net/"
SRC_URI="http://kcdlabel.sourceforge.net/download/${P}-KDE3.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

need-kde 3

src_compile(){
	append-flags -fpermissive
	kde_src_compile all
}
