# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/httpush/httpush-0.9_beta11.ebuild,v 1.1 2005/04/01 14:08:38 mrness Exp $

inherit eutils

MY_P="${P/_beta/b}"

DESCRIPTION="Httpush is an intercepting proxy, allowing user to modify HTTP requests on-the-fly"
HOMEPAGE="http://httpush.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="xml2"

RDEPEND="dev-perl/URI
	dev-perl/MIME-Base64
	dev-perl/libwww-perl
	dev-perl/Net-SSLeay
	dev-perl/Crypt-SSLeay
	dev-perl/HTML-Parser
	xml2? ( dev-perl/XML-Twig )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! useq xml2 ; then
		echo
		einfo "If you'd like to use httpush's learning mode, please CTRL-C now"
		einfo "and enable the xml2 USE flag."
		epause 3
		echo
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:^\(require httpush;\)$:push @INC, "/usr/lib/httpush";\n\1:' \
		httpush.pl || die "sed INC failed"
	sed -i 's:^\(.*DATADIR="\)data\(.*\)$:\1/var/lib/httpush\2:' *.pl \
		lib/plugin/broker.pm || die "sed DATADIR= failed"
}

src_install() {
	keepdir /var/lib/httpush

	insinto /usr/lib/httpush
	doins -r httpush.{dtd,lck,pem,pm} lib

	insinto /usr/share/httpush/plugins
	doins plugins/*

	newbin httpush.pl httpush
	newbin reindex.pl reindex

	dodoc README ChangeLog LICENSE doc/*
}
