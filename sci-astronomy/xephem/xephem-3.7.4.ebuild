# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/xephem/xephem-3.7.4.ebuild,v 1.2 2010/10/10 21:13:34 ulm Exp $

EAPI=2
inherit eutils

DESCRIPTION="Interactive tool for astronomical ephemeris and sky simulation"
HOMEPAGE="http://www.clearskyinstitute.com/xephem"
SRC_URI="http://97.74.56.125/free/${P}.tar.gz"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""
SLOT=0
LICENSE="as-is"

DEPEND=">=x11-libs/openmotif-2.3:0
	media-libs/jpeg
	media-libs/libpng"
RDEPEND="${DEPEND}"

src_prepare() {
	# make sure we use system libs and respect user flags
	epatch "${FILESDIR}"/${P}-libs-flags.patch
}

src_compile() {
	cd GUI/xephem
	emake || die "emake failed"
	for i in tools/{lx200xed,xedb,xephemdbd}; do
		emake -C ${i} || die "emake ${i} failed"
	done
}

src_install() {
	into "/usr"
	cd "${S}"/GUI/xephem
	dobin xephem  || die "dobin xephem failed"
	doman xephem.1 || die
	newicon XEphem.png ${PN}.png
	insinto /usr/share/${PN}
	for i in auxil catalogs fifos fits gallery lo; do
		doins -r ${i} || die
	done
	insinto /usr/share/doc/${PF}/html
	doins -r help/* || die
	cd tools
	for file in lx200xed/lx200xed xedb/xedb xephemdbd/xephemdbd; do
		dobin ${file} || die "dobin ${file} failed"
	done
	for file in {xedb,lx200xed}/README; do
		newdoc ${file} README.$(dirname ${file}) || die "newdoc ${file} failed"
	done
	cd xephemdbd
	insinto /usr/share/doc/${PF}/xephemdbd
	doins README cgi-lib.pl start-xephemdbd.pl xephemdbd.html xephemdbd.pl || die

	cd "${S}"
	echo > XEphem "XEphem.ShareDir: /usr/share/${PN}"
	insinto /usr/share/X11/app-defaults
	has_version '<x11-base/xorg-x11-7.0' && insinto /etc/X11/app-defaults
	doins XEphem || die
	echo > 99xephem "XEHELPURL=/usr/share/doc/${PF}/html/xephem.html"
	doenvd 99xephem || die
	dodoc Copyright README
	make_desktop_entry xephem XEphem ${PN}
}

pkg_postinst() {
	elog "See /usr/share/doc/${PF}/xephemdbd/README to set up a web interface"
}
