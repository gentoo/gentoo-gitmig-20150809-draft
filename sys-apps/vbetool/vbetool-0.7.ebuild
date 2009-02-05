# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vbetool/vbetool-0.7.ebuild,v 1.4 2009/02/05 05:43:04 darkside Exp $

inherit eutils flag-o-matic

DESCRIPTION="Run real-mode video BIOS code to alter hardware state (i.e. reinitialize video card)"
HOMEPAGE="http://www.codon.org.uk/~mjg59/vbetool/"
#SRC_URI="${HOMEPAGE}${PN}_${PV}.orig.tar.gz"
#SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${P//-/_}-1.tar.gz"
SRC_URI="http://www.srcf.ucam.org/~mjg59/${PN}/${P//-/_}-1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="zlib"
RDEPEND="zlib? ( sys-libs/zlib ) sys-apps/pciutils"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}-0.7"

#src_unpack() {
#	unpack ${A}
#	epatch ${FILESDIR}/${P}-pci-compile-fix.patch
#}

src_compile() {
	if use zlib
	then
		append-ldflags -lz
	elif built_with_use --missing false sys-apps/pciutils zlib
	then
		die "You need to build with USE=zlib to match sys-apps/pcituils"
	fi
	# when on non-x86 machines, we need to use the x86 emulator
	LIBS="-lpci" econf `use_with !x86 x86emu` || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc LRMI
}
