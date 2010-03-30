# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Dict-Leo-Org/WWW-Dict-Leo-Org-1.34-r2.ebuild,v 1.1 2010/03/30 06:35:44 jlec Exp $

EAPI="3"

MODULE_AUTHOR="TLINDEN"
inherit perl-app

DESCRIPTION="commandline interface to http://dict.leo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-lang/perl
	dev-perl/HTML-TableParser
	perl-core/DB_File"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-umlaut.patch
}

src_install() {
	perl-module_src_install
	mv "${D}"/usr/bin/{l,L}eo || die
}

pkg_postinst() {
	elog "We renamed leo to Leo"
	elog "due to conflicts with app-editors/leo"
}
