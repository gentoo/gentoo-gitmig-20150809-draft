# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/publib/publib-0.38.2.ebuild,v 1.2 2005/07/30 10:20:31 flameeyes Exp $

inherit versionator eutils

MY_P="${PN}-$(get_version_component_range 1-2)"
DEBIAN_SOURCE="${PN}_$(get_version_component_range 1-2).orig.tar.gz"
DEBIAN_PATCH="${PN}_$(replace_version_separator 2 '-').diff.gz"

DESCRIPTION="C library of misc utility functions (parsing, data structs, etc.)"
SRC_URI="mirror://debian/pool/main/p/publib/${DEBIAN_SOURCE}
	mirror://debian/pool/main/p/publib/${DEBIAN_PATCH}"
HOMEPAGE="http://packages.debian.org/testing/libdevel/publib-dev"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	epatch ${WORKDIR}/${DEBIAN_PATCH/.gz/}

	mkdir ${S}/objs
}

src_compile() {
	cd objs

	ECONF_SOURCE="../framework" \
		econf \
			--with-modules=${S}/liw \
			--with-library=publib \
			--with-libshort=pub || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# install extra docs
	dodoc Changes framework/README framework/TODO
	dodoc framework/Blurb debian/changelog

	# main install
	cd objs
	dodir /usr/share/man/mano /usr/$(get_libdir) /usr/include/publib

	make prefix=${D}/usr man3ext=o man3dir=${D}/usr/share/man/mano \
		libdir=${D}/usr/$(get_libdir) install || die "make install failed"

	# adjust man page titles to fit the "o" set above (instead of "3")
	sed -i -e 's/^\(\.TH [A-Z0-9]* \)3/\1o/' ${D}/usr/share/man/mano/*
}
