# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/anubis/anubis-1.7.0.1.ebuild,v 1.2 2007/07/22 09:03:16 graaff Exp $

inherit versionator

MY_PV=$(replace_all_version_separators '_' ${PV})
DESCRIPTION="mathematic logic based programming language"
HOMEPAGE="http://www.anubis-language.com"
SRC_URI="mirror://gentoo/Anubis_${MY_PV}_Linux.tar.gz"

LICENSE="anubis"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="media-libs/jpeg
		dev-libs/openssl
		x11-libs/libX11"

src_unpack() {
	unpack "${A}"
	mkdir "${S}"
	tar -C "${S}" -xzf anubis_binaries.tar.gz
	tar -C "${S}" -xzf anubis_files.tar.gz
}

src_install() {
	insinto /usr/share/${PN}
	doins -r library server_certs trusted_certs
	for i in en fr ; do
		insinto /usr/share/doc/${P}/${i}
		doins ${i}/*
	done
	dobin bin/*
}

pkg_postinst() {
	ewarn ""
	ewarn "Please note that anubis is distributed under a restrictive license."
	ewarn "   The right to use Anubis Personal Edition is granted for free for"
	ewarn "    non-profit and personal/family use only."
	ewarn "For other uses, please contact licencing@anubis-language.com or visit "
	ewarn "http://www.anubis-language.com"
	ewarn ""
}
