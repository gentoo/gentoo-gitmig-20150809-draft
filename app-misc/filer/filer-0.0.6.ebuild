# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/filer/filer-0.0.6.ebuild,v 1.2 2004/09/03 00:53:46 dholm Exp $

DESCRIPTION="Small file-manager written in perl"
HOMEPAGE="http://public.rz.fh-wolfenbuettel.de/~luedickj/"
SRC_URI="http://public.rz.fh-wolfenbuettel.de/~luedickj/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/gtk2-perl
	dev-perl/gtk2-gladexml
	dev-perl/File-MimeInfo
	dev-perl/File-Temp
	dev-perl/TimeDate
	dev-perl/Stat-lsMode"

S=${WORKDIR}/${PN}

src_compile() {
	true
}

src_install() {
	newbin filer.pl filer || die
	dodir /usr/lib/filer
	cp -R Filer icons lib.pl ${D}/usr/lib/filer
}
