# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/srecord/srecord-1.40.ebuild,v 1.1 2008/04/28 12:50:30 calchan Exp $

DESCRIPTION="A collection of powerful tools for manipulating EPROM load files."
HOMEPAGE="http://srecord.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="test"

DEPEND="test? ( app-arch/sharutils )"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
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
