# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bwwhois/bwwhois-3.4-r1.ebuild,v 1.1 2006/10/27 19:39:41 drizzt Exp $

inherit perl-app

MY_P=${P/bw/}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl-based whois client designed to work with the new Shared Registration System"
SRC_URI="http://whois.bw.org/dist/${MY_P}.tgz"
HOMEPAGE="http://whois.bw.org/"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="app-admin/eselect-whois"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	einfo "no compilation necessary"
}

src_install () {
	exeinto usr/bin
	newexe whois bwwhois

	mv whois.1 bwwhois.1
	doman bwwhois.1

	insinto etc/whois
	doins whois.conf tld.conf sd.conf

	perlinfo
	insinto ${SITE_LIB}
	doins bwInclude.pm
	updatepod
}

pkg_postinst() {
	einfo "Setting /usr/bin/whois symlink"
	eselect whois update --if-unset
}

pkg_postrm() {
	einfo "Updating /usr/bin/whois symlink"
	eselect whois update
}
