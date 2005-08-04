# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdlabel/kcdlabel-2.12-r1.ebuild,v 1.5 2005/08/04 08:06:43 blubb Exp $

inherit flag-o-matic kde eutils

S=${WORKDIR}/${P}-KDE3

DESCRIPTION="cd label printing tool for kde"
HOMEPAGE="http://kcdlabel.sourceforge.net/"
SRC_URI="http://kcdlabel.sourceforge.net/download/${P}-KDE3.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

need-kde 3

src_unpack(){
	kde_src_unpack
	epatch ${FILESDIR}/${P}-configure-arts.patch
}
src_compile(){
	append-flags -fpermissive
	kde_src_compile all
}
