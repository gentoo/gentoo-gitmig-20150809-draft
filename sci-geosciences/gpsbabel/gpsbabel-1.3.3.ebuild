# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsbabel/gpsbabel-1.3.3.ebuild,v 1.2 2007/03/28 11:55:28 cryos Exp $

inherit eutils

DESCRIPTION="GPSBabel is a waypoints, tracks and routes converter in variety of form"

HOMEPAGE="http://www.gpsbabel.org/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="doc usb debug"

RDEPEND="dev-libs/expat
	usb? ( dev-libs/libusb )
	debug? ( dev-util/efence )"

DEPEND="doc? ( virtual/tetex dev-libs/libxslt dev-libs/libxml2 dev-lang/perl )
	${RDEPEND}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.patch || die "Unable to apply ${P}.patch"
}

src_compile() {
	local myconf="";
	if ! use usb;then
		myconf="${myconf} --with-libusb=no"
	fi
	if use doc; then
		myconf="${myconf} --with-doc=${S}/doc/manual"
	fi
	econf ${myconf} $(use_enable debug efence)
	emake || die "emake failed"
	if use doc; then
		emake doc || die "Documentation generation failed"
		cd "${S}/doc"
		make || die "Documentation generation failed"
	fi
}

src_install() {
	cd "${S}"
	make DESTDIR="${D}" install || die "Install failed"
	dodoc README* || die "Unable to install gpsbabel doc"
	if use doc; then
		cd "${S}"/doc/
		dohtml ./manual/htmldoc-${PV}/* || die "Unable to install htmldoc"
		docinto manual
		dodoc doc.dvi babelfront2.eps || \
			die "Unable to install gpsbabel documentation"
	fi
}

pkg_postinst(){
	if use debug; then
		einfo "If you need to debug gpsbabel, please use : gpsbabel-debug"
	fi
}
