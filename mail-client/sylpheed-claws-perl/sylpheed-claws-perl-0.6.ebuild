# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-perl/sylpheed-claws-perl-0.6.ebuild,v 1.2 2006/04/17 18:38:58 corsair Exp $

MY_P="${P##sylpheed-claws-}"
MY_PN="${PN##sylpheed-claws-}"
SC_BASE="2.0.0"
SC_BASE_NAME="sylpheed-claws-extra-plugins-${SC_BASE}"

DESCRIPTION="Plugin for sylpheed-claws to use perl to write filtering rules"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/${SC_BASE_NAME}.tar.bz2"
#SRC_URI="http://claws.sylpheed.org/downloads/${MY_PN}_plugin-${PV}_gtk2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}
		dev-lang/perl"

S="${WORKDIR}/${SC_BASE_NAME}/${MY_PN}_plugin-${PV}"

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

	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}

pkg_postinst() {
	einfo "The documentation for this plugin is contained in a manpage."
	einfo "You can access it with 'man sc_perl'"
}
