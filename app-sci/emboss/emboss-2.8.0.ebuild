# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/emboss/emboss-2.8.0.ebuild,v 1.3 2004/01/20 21:32:01 sediener Exp $


S=${WORKDIR}/EMBOSS-${PV}
DESCRIPTION="The European Molecular Biology Open Software Suite: EMBOSS is a package of high-quality FREE Open Source software for sequence analysis"
HOMEPAGE="http://www.emboss.org/"
SRC_URI="ftp://ftp.uk.embnet.org/pub/EMBOSS/EMBOSS-${PV}.tar.gz"
LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="png X"
DEPEND="X? ( virtual/x11 )
	png? ( >=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.2.4
	>=media-libs/libgd-1.8.4 )"

src_install() {
	einstall || die

	# env file
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/22emboss

	#install files...
	dodoc AUTHORS COMPAT COPYING ChangeLog FAQ INSTALL KNOWN_BUGS LICENSE README THANKS NEWS ONEWS PROBLEMS

	# symlink preinstalled docs to /usr/share...
	dosym /usr/share/EMBOSS/doc/manuals /usr/share/doc/${P}/manuals
	dosym /usr/share/EMBOSS/doc/programs /usr/share/doc/${P}/programs
	dosym /usr/share/EMBOSS/doc/tutorials /usr/share/doc/${P}/tutorials


}

src_compile() {

	econf || die
	emake || die
}

