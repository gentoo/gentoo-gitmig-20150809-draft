# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkimg/tkimg-1.3.ebuild,v 1.3 2008/10/03 19:38:07 bluebird Exp $

inherit eutils autotools

MY_P=${PN}${PV}
DESCRIPTION="Adds a lot of image formats to Tcl/Tk"
HOMEPAGE="http://sourceforge.net/projects/tkimg/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"

DEPEND="dev-lang/tk
	media-libs/libpng
	media-libs/tiff"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/${P}-syslibs.patch
	epatch "${FILESDIR}"/${P}-makedeps.patch
	epatch "${FILESDIR}"/${P}-warnings.patch
	rm -f $(find . -name configure)
	for i in $(find -type d); do
		cd "${S}"/${i}
		[[ -f configure.in ]] && eautoreconf
	done
}

src_install() {
	emake \
		DESTDIR="${D}" \
		INSTALL_ROOT="${D}" \
		install || die "emake install failed"
	doman doc/man/*
	dodoc ChangeLog README Reorganization.Notes.txt changes ANNOUNCE || die
	insinto /usr/share/doc/${PF}
	doins -r demo
	use doc && dohtml doc/html
}
