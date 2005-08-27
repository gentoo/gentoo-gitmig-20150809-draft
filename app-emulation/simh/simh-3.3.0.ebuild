# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/simh/simh-3.3.0.ebuild,v 1.1 2005/08/27 20:59:39 rphillips Exp $

inherit eutils

DESCRIPTION="a simulator for historical computers such as Vax, PDP-11 etc.)"
HOMEPAGE="http://simh.trailing-edge.com/"
SRC_URI="http://simh.trailing-edge.com/sources/simhv33-0.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND="net-libs/libpcap"

S=${WORKDIR}

MAKEOPTS="USE_NETWORK=1 ${MAKEOPTS}"


src_unpack() {
	mkdir ${WORKDIR}/BIN
	unpack ${A}

	# convert makefile from dos format to unix format
	sed -i 's/.$//' makefile

	epatch ${FILESDIR}/makefile.patch
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	cd "${S}/BIN"
	for BINFILE in *; do
		newbin ${BINFILE} "simh-${BINFILE}"
	done

	cd ${S}
	dodir /usr/share/simh
	insinto /usr/share/simh
	doins VAX/*.bin
	dodoc *.txt */*.txt
}
