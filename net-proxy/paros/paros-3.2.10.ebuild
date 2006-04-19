# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/paros/paros-3.2.10.ebuild,v 1.1 2006/04/19 06:29:21 mrness Exp $

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

	epatch "${FILESDIR}/without_embed.patch"
}

src_compile() {
	cd "${S}/build"
	ant dist || die "ant failed"
}

src_install() {
	sed -i -e '1i#!/bin/sh' -e "1icd /usr/share/${PN}" "build/${PN}/startserver.sh"
	newbin "build/${PN}/startserver.sh" "${PN}"
	rm build/"${PN}"/startserver.*

	insinto /usr/share
	doins -r "build/${PN}"

	dodoc src/doc/{*.txt,*.rtf}
}
