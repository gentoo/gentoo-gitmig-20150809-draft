# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/anubis/anubis-1.7.0.1.ebuild,v 1.3 2007/08/27 16:40:50 drac Exp $

inherit eutils versionator

MY_PV=$(replace_all_version_separators '_' ${PV})

DESCRIPTION="mathematic logic based programming language"
HOMEPAGE="http://www.anubis-language.com"
SRC_URI="mirror://gentoo/Anubis_${MY_PV}_Linux.tar.gz"

LICENSE="anubis"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="x86? ( media-libs/jpeg
	x11-libs/libX11
	virtual/libstdc++ )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat )"

RESTRICT="strip"

src_unpack() {
	unpack ${A}
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

	exeinto /opt/${PN}
	doexe bin/*

	insinto /opt/${PN}/lib
	doins lib/lib{ssl,crypto}.so.0.9.7

	make_wrapper anubis ./anubis /opt/${PN} /opt/${PN}/lib || die "make_wrapper failed."
	make_wrapper anbexec ./anbexec /opt/${PN} /opt/${PN}/lib || die "make_wrapper failed."
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
