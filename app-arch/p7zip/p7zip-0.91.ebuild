# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/p7zip/p7zip-0.91.ebuild,v 1.1 2004/09/26 19:15:53 radek Exp $

DESCRIPTION="Port of 7-Zip archiver for Unix."
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.bz2"

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
	dodir /usr/lib/7z
	cp -R bin/Codecs bin/Formats ${D}/usr/lib/7z
	cp bin/7z ${D}/usr/lib/7z

	dobin ${FILESDIR}/7z
	dobin bin/7za

	dodoc ChangeLog README TODO

	use doc && dohtml -r html/* ${D}/usr/share/doc/${P}
}
