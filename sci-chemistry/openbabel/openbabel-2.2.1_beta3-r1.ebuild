# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/openbabel/openbabel-2.2.1_beta3-r1.ebuild,v 1.1 2009/02/28 20:49:33 cryos Exp $

EAPI=1

inherit eutils

MY_PV="2.2.1b3-20090215-r2890"

DESCRIPTION="interconverts file formats used in molecular modeling"
HOMEPAGE="http://openbabel.sourceforge.net/"
SRC_URI="mirror://sourceforge/openbabel/${PN}-${MY_PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="doc"

RDEPEND="!sci-chemistry/babel
	>=dev-libs/libxml2-2.6.5
	sys-libs/zlib"

DEPEND="${RDEPEND}
	>=dev-libs/boost-1.33.1
	dev-lang/perl
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.2.0-doxyfile.patch"
}

src_compile() {
	econf \
		--enable-static \
		|| die "econf failed"
	emake || die "emake failed"
	if use doc ; then
		emake docs || "make docs failed"
	fi
}

src_test() {
	emake check || die "make check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
	cd doc
	dohtml *.html *.png
	dodoc *.inc README* *.inc *.mol2
	if use doc ; then
		dodir /usr/share/doc/${PF}/API/html
		insinto /usr/share/doc/${PF}/API/html
		cd API/html
		doins *
	fi
}

pkg_postinst() {
	echo
	elog "This version of OpenBabel includes InChI version 1 (software version"
	elog "1.02_beta). It does not produce Standard InChI/InChIKey."
	elog "To get Standard InChI/InChIKey software version 1.02 must be used."
}
