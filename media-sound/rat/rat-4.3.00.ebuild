# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rat/rat-4.3.00.ebuild,v 1.1 2007/08/01 13:57:15 drac Exp $

MY_P=mediatools-13sept06

DESCRIPTION="Robust Audio Tool for audio conferencing and streaming"
HOMEPAGE="http://mediatools.cs.ucl.ac.uk/nets/mmedia/wiki/RatWiki"
SRC_URI="http://mediatools.cs.ucl.ac.uk/software/${PN}/releases/${PV}/${MY_P}.src.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

RDEPEND="=dev-lang/tcl-8.4*
	=dev-lang/tk-8.4*"
DEPEND="${RDEPEND}
	 sys-apps/gawk"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# borqued reference doc, yick!
	sed -i -e 's:@OPTDOC@::' common/Makefile.in
}

src_compile() {
	cd "${S}"/common
	econf
	emake || die "emake failed."

	cd "${S}"/rat
	econf --with-tcltk-version=8.4 \
		--with-tcl=/usr \
		--with-tk=/usr
	emake || die "emake failed."
}

src_install() {
	cd "${S}"/rat
	dobin rat-4.3.00
	dobin rat-4.3.00-ui
	dobin rat-4.3.00-media
	doman man/man1/rat.1
	dodoc VERSION MODS README*
	insinto /etc/sdr/plugins
	doins sdr2.plugin.S*
}
