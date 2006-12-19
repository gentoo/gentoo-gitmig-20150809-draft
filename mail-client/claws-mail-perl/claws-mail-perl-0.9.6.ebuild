# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-perl/claws-mail-perl-0.9.6.ebuild,v 1.1 2006/12/19 20:36:14 ticho Exp $

MY_P="${PN#claws-mail-}_plugin-${PV}"

DESCRIPTION="Plugin for sylpheed-claws to use perl to write filtering rules"
HOMEPAGE="http://www.claws-mail.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/claws-mail-2.6.1
		dev-lang/perl"

S="${WORKDIR}/${MY_P}"

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
	exeinto /usr/lib/claws-mail/tools
	doexe *.pl

	rm -f ${D}/usr/lib*/claws-mail/plugins/*.{a,la}
}

pkg_postinst() {
	echo
	elog "The documentation for this plugin is contained in a manpage."
	elog "You can access it with 'man cm_perl'"
	echo
}
