# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skalibs/skalibs-0.30.ebuild,v 1.2 2003/09/06 22:29:25 msterret Exp $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

DESCRIPTION="common libraries for skarnet.org packages"
HOMEPAGE="http://www.skarnet.org/software/skalibs/"
SRC_URI="http://www.skarnet.org/software/skalibs/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
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
	package/install
}

src_install() {
	insinto ${MY_INSTALL}/library
	doins library/*.a
	insinto ${MY_INSTALL}/sysdeps
	doins sysdeps/*
	insinto ${MY_INSTALL}/include
	doins include/*
}
