# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ted/ted-2.17-r1.ebuild,v 1.1 2008/01/18 03:26:24 dirtyepic Exp $

DESCRIPTION="X-based rich text editor"
HOMEPAGE="http://www.nllgg.nl/Ted"
SRC_URI="ftp://ftp.nluug.nl/pub/editors/ted/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="x11-libs/openmotif
	>=media-libs/tiff-3.5.7
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.3"

S="${WORKDIR}/Ted-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"/Ted
	sed -i \
		-e 's@^CFLAGS=@CFLAGS= -DDOCUMENT_DIR=\\"/usr/share/doc/${PF}/\\"@' \
		makefile.in
}

src_compile() {
	# This is a fix for userpriv &| usersandbox.
	RPM_BUILD_ROOT="${S}"
	for dir in Ted tedPackage appFrame appUtil ind bitmap libreg; do
		cd "${S}"/${dir}
		econf --cache-file=../config.cache || die "econf ${dir} failed"
	done

	# The makefile doesn't really allow parallel make, but it does
	# no harm either.
	cd "${S}"
	emake \
		DEF_AFMDIR=-DAFMDIR=\\\"/usr/share/Ted/afm\\\" \
		DEF_INDDIR=-DINDDIR=\\\"/usr/share/Ted/ind\\\" \
		package.shared \
		|| die "emake failed"
}

src_install() {
	# This build system is a little insane.  Above we made a package, here we
	# will unpack it and install it.  We have to do it this way or it doesn't
	# link properly.  We could rewrite the Makefile, but this works just as
	# well.

	# This is a fix for userpriv &| usersandbox.
	RPM_BUILD_ROOT="${S}"

	mkdir "${S}"/pkg
	cd "${S}"/pkg
	# can't use unpack here
	tar xf ../tedPackage/Ted*.tar.gz || die "failed unpacking ted package"

	insinto /usr/share/Ted/afm
	doins afm/*
	insinto /usr/share/Ted/ind
	doins ind/*

	dobin bin/Ted

	doman Ted/Ted.1
	rm Ted/Ted.1

	# must stay uncompressed (used internally)
	insinto /usr/share/doc/${PF}
	doins Ted/TedDocument-en_US.rtf
	rm Ted/TedDocument-en_US.rtf

	dodoc Ted/*
}
