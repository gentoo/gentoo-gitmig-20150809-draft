# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skalibs/skalibs-0.47.ebuild,v 1.1 2009/02/04 14:36:35 patrick Exp $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

DESCRIPTION="common libraries for skarnet.org packages"
HOMEPAGE="http://www.skarnet.org/software/skalibs/"
SRC_URI="http://www.skarnet.org/software/skalibs/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-libs/dietlibc"
#RDEPEND=""

MY_INSTALL="/package/prog/skalibs/"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  S will get a default setting of ${WORKDIR}/${P}
# if you omit this line.
S=${WORKDIR}/prog/${P}

src_unpack() {
	unpack ${A}

	cd ${S}/src/headers
	patch gccattributes.h < ${FILESDIR}/skalibs-0.30-gccattributes.h.patch
}

src_compile() {
	package/install || die "Failed to compile"
}

src_install() {
	insinto ${MY_INSTALL}/library
	doins library/*.a
	insinto ${MY_INSTALL}/sysdeps
	doins sysdeps/*
	insinto ${MY_INSTALL}/include
	doins include/*
}
