# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rat/rat-4.2.23.ebuild,v 1.4 2004/04/01 07:50:58 eradicator Exp $

DESCRIPTION="Robust Audio Tool for audio conferencing and streaming"
HOMEPAGE="http://www-mice.cs.ucl.ac.uk/multimedia/software/rat/"
SRC_URI="http://www-mice.cs.ucl.ac.uk/multimedia/software/rat/releases/${PV}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="=dev-lang/tcl-8.3*
	=dev-lang/tk-8.3*"

RDEPEND="${DEPEND}
	 sys-apps/gawk"

src_compile() {
	cd ${S}/common
	econf || die
	emake || die
	cd ${S}/rat
	econf --with-tcltk-version=8.3 \
		--with-tcl=/usr \
		--with-tk=/usr || die
	emake || die
}


src_install() {
	cd ${S}/rat
	insinto ${D}
	dobin rat-4.2.23
	dobin rat-4.2.23-ui
	dobin rat-4.2.23-media
	dodoc COPYRIGHT MODS README README.IXJ README.WB-ADPCM README.debug
	dodoc README.devices README.files README.g728 README.gsm
	dodoc README.mbus README.playout README.reporting-bugs
	dodoc README.settings README.timestamps README.voxlet VERSION
}


