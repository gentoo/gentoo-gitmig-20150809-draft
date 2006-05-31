# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/koverartist/koverartist-0.4.ebuild,v 1.2 2006/05/31 09:54:25 mattepiu Exp $

inherit kde eutils

S=${WORKDIR}/${PN}
DESCRIPTION="Koverartist is a KDE program for fast creation of covers for cd/dvd cases and boxes."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=38195"
SRC_URI="http://members.inode.at/499177/software/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""
DEPEND="!app-cdr/kover"
need-kde 3.3

src_compile () {
	cd ${S}
	PREFIX=`kde-config --prefix`
	kde_src_compile
}
