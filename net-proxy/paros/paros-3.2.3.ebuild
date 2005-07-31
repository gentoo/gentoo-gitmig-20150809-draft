# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/paros/paros-3.2.3.ebuild,v 1.2 2005/07/31 11:17:55 dholm Exp $

inherit eutils

DESCRIPTION="HTTP/HTTPS proxy for evaluate security of web applications"
HOMEPAGE="http://www.parosproxy.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip
	>=virtual/jdk-1.4.2
	dev-java/ant"
RDEPEND=">=virtual/jre-1.4.2"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PF}-unixhome.patch
}

src_compile() {
	cd ${S}/build
	ant dist || die "ant failed"
}

src_install() {
	sed -i -e '1i#!/bin/sh' -e "1icd /usr/share/${PN}" build/${PN}/startserver.sh
	newbin build/${PN}/startserver.sh ${PN}
	rm build/${PN}/startserver.*

	insinto /usr/share
	doins -r build/${PN}

	dodoc src/doc/{*.txt,*.rtf}
}
