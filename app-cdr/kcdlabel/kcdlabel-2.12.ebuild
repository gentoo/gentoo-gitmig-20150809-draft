# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdlabel/kcdlabel-2.12.ebuild,v 1.12 2005/01/12 15:10:30 sekretarz Exp $

inherit flag-o-matic kde

S=${WORKDIR}/${P}-KDE3

DESCRIPTION="cd label printing tool for kde"
HOMEPAGE="http://kcdlabel.sourceforge.net/"
SRC_URI="http://kcdlabel.sourceforge.net/download/${P}-KDE3.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

need-kde 3

src_compile(){
	append-flags -fpermissive
	kde_src_compile all
}