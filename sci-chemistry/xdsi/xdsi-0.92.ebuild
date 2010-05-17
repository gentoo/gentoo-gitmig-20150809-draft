# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/xdsi/xdsi-0.92.ebuild,v 1.1 2010/05/17 15:25:21 jlec Exp $

EAPI="3"

inherit eutils

DESCRIPTION="A crude interface for running the XDS"
HOMEPAGE="http://strucbio.biologie.uni-konstanz.de/xdswiki/index.php/Xdsi"
SRC_URI="ftp://turn5.biologie.uni-konstanz.de/pub/${PN}_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	sci-chemistry/mosflm
	sci-chemistry/xds-bin[smp]
	sci-chemistry/pointless
	sci-visualization/xds-viewer
	sci-visualization/gnuplot
	media-gfx/imagemagick
	app-text/xpdf
	dev-lang/tk"
# Need to clarified for licensing
# sci-chemistry/xdsstat-bin
DEPEND=""

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	sed "s:GENTOOTEMPLATE:${EPREFIX}/usr/share/${PN}/templates:g" -i ${PN} \
	|| die
}

src_install() {
	dobin ${PN} || die
	insinto /usr/share/${PN}/templates
	doins templates/{*.INP,bohr*,fortran,pauli,info.png,*.pck,tablesf_xdsi} || die
	dodoc templates/*.pdf || die
}

pkg_postinst() {
	elog "Documentation can be found here:"
	elog "ftp://turn14.biologie.uni-konstanz.de/pub/xdsi/xdsi_doc_print.pdf"
}
