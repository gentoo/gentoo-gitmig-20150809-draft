# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/neroaac/neroaac-1.5.1.ebuild,v 1.2 2011/02/27 20:54:44 hwoarang Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Nero AAC reference quality MPEG-4 and 3GPP audio codec"
HOMEPAGE="http://www.nero.com/enu/technologies-aac-codec.html"
SRC_URI="http://ftp6.nero.com/tools/NeroAACCodec-${PV}.zip"

LICENSE="Nero-AAC-EULA"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="app-arch/unzip"

RESTRICT="strip mirror test"

QA_PRESTRIPPED="opt/${PN}/${PV}/neroAac\(Dec\|Enc\|Tag\)"
QA_EXECSTACK="opt/${PN}/${PV}/neroAacDec opt/${PN}/${PV}/neroAacEnc"

S="${WORKDIR}"

src_prepare() {
	edos2unix *.txt
}

src_install() {
	exeinto /opt/${PN}/${PV}
	doexe linux/*
	dodir /opt/bin
	dosym ../${PN}/${PV}/neroAacDec /opt/bin
	dosym ../${PN}/${PV}/neroAacEnc /opt/bin
	dosym ../${PN}/${PV}/neroAacTag /opt/bin
	newdoc readme.txt README
	newdoc license.txt LICENSE
	newdoc changelog.txt ChangeLog
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins NeroAAC_tut.pdf
	fi
}
