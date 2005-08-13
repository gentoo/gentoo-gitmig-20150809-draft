# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-perl/sylpheed-claws-perl-0.3.ebuild,v 1.1 2005/08/13 10:47:56 genone Exp $

MY_P="${P##sylpheed-claws-}"
MY_PN="${PN##sylpheed-claws-}"
SC_BASE="1.9.13"

DESCRIPTION="Plugin for sylpheed-claws to use perl to write filtering rules"
HOMEPAGE="http://sylpheed-claws.sourceforge.net"
SRC_URI="mirror://sourceforge/sylpheed-claws/sylpheed-claws-plugins-${SC_BASE}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}
		dev-lang/perl"

S="${WORKDIR}/${MY_PN}_plugin-${PV}"

src_compile() {
	econf || die
	emake || die

	pod2man --section=1 --release=${PV} --name=sc_perl sc_perl.pod > sc_perl.1

	cd tools
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	doman sc_perl.1

	cd tools
	exeinto /usr/lib/sylpheed-claws/tools
	doexe *.pl

	einfo "The documentation for this plugin is contained in a manpage. Use 'man sc_perl' to read it."
}
