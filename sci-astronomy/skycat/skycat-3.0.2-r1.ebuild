# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/skycat/skycat-3.0.2-r1.ebuild,v 1.2 2009/09/16 04:20:56 markusle Exp $

inherit eutils autotools

DESCRIPTION="ESO astronomical image visualizer with catalog access."
HOMEPAGE="http://archive.eso.org/skycat"
SRC_URI="ftp://ftp.eso.org/pub/archive/${PN}/Sources/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="threads"

RDEPEND="${DEPEND}"
DEPEND="x11-libs/libXext
	>=dev-tcltk/tclx-2.4
	>=dev-tcltk/blt-2.4
	>=dev-tcltk/itcl-3.3
	>=dev-tcltk/iwidgets-4.0.1
	>=dev-tcltk/tkimg-1.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix buggy tcl.m4 for bash3
	epatch "${FILESDIR}"/${PN}-3.0.1-m4.patch
	# fix old style headers, set as error by new g++
	epatch "${FILESDIR}"/${PN}-3.0.1-gcc43.patch

	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	# need fix for tk-8.5
	if has_version ">=dev-lang/tk-8.5" ; then
		epatch "${FILESDIR}"/${P}-tk8.5.patch
	fi

	eautoconf
}

src_compile() {
	econf $(use_enable threads)
	emake
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README CHANGES VERSION
	for d in tclutil astrotcl rtd cat skycat; do
		for f in README CHANGES VERSION; do
			newdoc ${f} ${f}.${d}
		done
	done
}
