# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rat/rat-4.2.25.ebuild,v 1.1 2004/11/23 04:39:57 eradicator Exp $

IUSE=""

DESCRIPTION="Robust Audio Tool for audio conferencing and streaming"
HOMEPAGE="http://www-mice.cs.ucl.ac.uk/multimedia/software/rat/"
SRC_URI="http://www-mice.cs.ucl.ac.uk/multimedia/software/rat/releases/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~sparc ~x86"

DEPEND="=dev-lang/tcl-8.4*
	=dev-lang/tk-8.4*"

RDEPEND="${DEPEND}
	 sys-apps/gawk"

src_unpack() {
	unpack ${A}
	sed -i 's:-Werror::g' ${S}/common/configure ${S}/rat/configure
}

src_compile() {
	cd ${S}/common
	econf || die
	emake || die

	cd ${S}/rat
	econf --with-tcltk-version=8.4 \
		--with-tcl=/usr \
		--with-tk=/usr || die
	emake || die
}

src_install() {
	cd ${S}/rat
	dobin rat-4.2.25
	dobin rat-4.2.25-ui
	dobin rat-4.2.25-media
	dodoc COPYRIGHT MODS README README.IXJ README.WB-ADPCM README.debug
	dodoc README.devices README.files README.g728 README.gsm
	dodoc README.mbus README.playout README.reporting-bugs
	dodoc README.settings README.timestamps README.voxlet VERSION
}
