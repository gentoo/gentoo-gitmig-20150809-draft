# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/drdsl/drdsl-1.2.0.ebuild,v 1.4 2006/03/12 10:10:03 mrness Exp $

DESCRIPTION="AVM DSL Assistant for autodetecting DSL values (VPI, VCI, VPP) for 'fcdsl' based cards"
HOMEPAGE="ftp://ftp.in-berlin.de/pub/capi4linux/"
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/drdsl/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -*"
IUSE="unicode"

DEPEND="sys-apps/coreutils"
RDEPEND="sys-libs/glibc
	net-dialup/capi4k-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# convert 'crlf' to 'lf'
	for i in drdsl.ini; do
		tr -d "\r" < "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	# convert 'latin1' to 'utf8'
	if use unicode; then
		for i in drdsl.ini; do
			einfo "Converting '${i}' to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_install() {
	dosbin drdsl
	insinto /etc/drdsl
	doins drdsl.ini
	dodoc README
}
