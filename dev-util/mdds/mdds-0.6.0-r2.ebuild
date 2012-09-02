# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mdds/mdds-0.6.0-r2.ebuild,v 1.2 2012/09/02 16:49:08 scarabeus Exp $

EAPI=4

inherit base

DESCRIPTION="A collection of multi-dimensional data structure and indexing algorithm"
HOMEPAGE="http://code.google.com/p/multidimalgorithm/"
SRC_URI="http://multidimalgorithm.googlecode.com/files/${P/-/_}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/-/_}

PATCHES=(
	"${FILESDIR}/${PV}-fix-boost-1.50-linking.patch"
	"${FILESDIR}/${PV}-fix-missing-includes.patch"
	"${FILESDIR}/${PV}-multi-vector-build.patch"
	"${FILESDIR}/${PV}-right-overload-of-vector.patch"
)

src_configure() {
	econf \
		--with-hash-container=boost \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_compile() { :; }
