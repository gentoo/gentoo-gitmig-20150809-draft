# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/p7zip/p7zip-4.10.ebuild,v 1.2 2005/01/01 11:50:22 eradicator Exp $

DESCRIPTION="Port of 7-Zip archiver for Unix."
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src.tar.bz2"

SLOT="0"
IUSE="doc"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

S=${WORKDIR}/${PN}_${PV}

src_compile ()
{
	make || die "compilation error"
}

src_install ()
{

	#dobin ${FILESDIR}/7z
	dobin bin/7za
	dosym 7za /usr/bin/7z

	dodoc ChangeLog README TODO DOC/*

	use doc && dohtml -r html/* ${D}/usr/share/doc/${P}
}
