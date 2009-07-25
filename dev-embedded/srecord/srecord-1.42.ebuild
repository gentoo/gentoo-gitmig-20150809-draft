# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/srecord/srecord-1.42.ebuild,v 1.2 2009/07/25 19:21:34 ssuominen Exp $

inherit eutils

DESCRIPTION="A collection of powerful tools for manipulating EPROM load files."
HOMEPAGE="http://srecord.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="test"

DEPEND="dev-libs/boost
	test? ( app-arch/sharutils )"
RDEPEND=""

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gcc44.patch
	sed -i \
		-e 's/(SOELIM) -I. -Ietc man\/man1/(SOELIM) -I. -Ietc -Iman\/man1 man\/man1/' \
		-e 's/(SOELIM) -I. -Ietc man\/man5/(SOELIM) -I. -Ietc -Iman\/man5 man\/man5/' \
		-e '/\$(mandir)\/man1\/srec_license.1 \\/d' \
		"${S}"/Makefile.in || die "Patching failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc "${S}"/README
	insinto /usr/share/doc/${PF}
	doins "${S}"/etc/reference.ps
}

src_test() {
	make sure || die "Tests failed"
}
