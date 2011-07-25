# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/cdsclient/cdsclient-3.6a.ebuild,v 1.1 2011/07/25 22:57:26 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="Collection of scripts to access the CDS databases"
HOMEPAGE="http://cdsweb.u-strasbg.fr/doc/cdsclient.html"
SRC_URI="ftp://cdsarc.u-strasbg.fr/pub/sw/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="app-shells/tcsh"

S="${WORKDIR}/${PN}-3.6"
src_prepare() {
	epatch "${FILESDIR}"/${PN}-makefile.in.patch
	# remove non standard "mantex" page
	sed -i \
		-e 's/aclient.tex//' \
		"${S}"/configure || die "sed failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man
	dodir /usr/$(get_libdir)
	emake \
		PREFIX="${D}"/usr \
		MANDIR="${D}"/usr/share/man \
		LIBDIR="${D}"/usr/$(get_libdir) \
		install || die "emake install failed"
}
