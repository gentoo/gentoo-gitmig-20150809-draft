# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-3.0.0_rc1.ebuild,v 1.1 2006/10/17 04:10:33 djay Exp $

DESCRIPTION="Geometry Engine - Open Source"
HOMEPAGE="http://geos.refractions.net"
SRC_URI="http://geos.refractions.net/${PN}-${PV/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"
IUSE="doc python ruby"

RDEPEND="virtual/libc
	ruby? ( virtual/ruby )
	python? ( virtual/python )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )\
	ruby?  ( virtual/ruby >=dev-lang/swig-1.3.29 )
	python? ( virtual/python >=dev-lang/swig-1.3.29 )"

S="${WORKDIR}/${PN}-${PV/_/}"

src_compile() {
	local myconf
	if use python || use ruby; then
		myconf="--with-pic"
	else
		 myconf="--disable-swig"
	fi
	econf ${myconf} $(use_enable python) $(use_enable ruby) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	into /usr
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	if use doc; then
		cd ${S}/doc
		make doxygen-html || die "doc generation failed"
		dohtml -r doxygen_docs/html/*
	fi
}
