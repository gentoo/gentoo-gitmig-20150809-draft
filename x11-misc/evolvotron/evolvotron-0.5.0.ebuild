# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/evolvotron/evolvotron-0.5.0.ebuild,v 1.3 2007/11/09 15:40:47 cla Exp $

inherit qt3

DESCRIPTION="An interactive generative art application"
HOMEPAGE="http://www.bottlenose.demon.co.uk/share/evolvotron/index.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(qt_min_version 3)"
DEPEND="${RDEPEND}
	dev-libs/boost"

S="${WORKDIR}"/${PN}

src_compile() {
	export PATH="${QTDIR}/bin:${PATH}"
	econf || die "econf failed."
	emake -j1 || die "emake failed."
}

src_install() {
	for bin in ${PN}{,_match,_mutate,_render}; do
		dobin ${bin}/${bin}
	done

	doman man/man1/*

	dodoc BUGS CHANGES README TODO USAGE
}
