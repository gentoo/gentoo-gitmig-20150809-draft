# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/p7zip/p7zip-4.12.ebuild,v 1.1 2004/12/04 17:39:02 radek Exp $

inherit eutils

DESCRIPTION="Port of 7-Zip archiver for Unix."
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src.tar.bz2"

SLOT="0"
IUSE="doc static"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

S=${WORKDIR}/${PN}_${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	if useq static ; then
		einfo "Static linkage enabled, patching makefile now.."
		epatch ${FILESDIR}/p7zip-4.12_x86_static.patch
	else
		einfo "Dynamic linkage enabled."
	fi
}

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
