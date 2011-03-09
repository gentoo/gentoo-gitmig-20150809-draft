# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/emboss/emboss-4.0.0.ebuild,v 1.15 2011/03/09 19:50:38 armin76 Exp $

EAPI=1

DESCRIPTION="The European Molecular Biology Open Software Suite - A sequence analysis package"
HOMEPAGE="http://emboss.sourceforge.net/"
SRC_URI="ftp://${PN}.open-bio.org/pub/EMBOSS/EMBOSS-${PV}.tar.gz"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="X png minimal"

DEPEND="
	X? ( x11-libs/libXt )
	png? (
		sys-libs/zlib
		media-libs/libpng
		media-libs/gd
		)
	!minimal? (
		sci-biology/primer3
		sci-biology/clustalw:1
	)
	!<dev-util/pscan-20000721-r1"

RDEPEND="${DEPEND}
	!sys-devel/cons"

PDEPEND="
	!minimal? (
		sci-biology/aaindex
		sci-biology/cutg
		sci-biology/prints
		sci-biology/prosite
		sci-biology/rebase
		sci-biology/transfac
	)"

S="${WORKDIR}/EMBOSS-${PV}"

src_compile() {
	local myconf
	myconf="--includedir=${D}/usr/include/emboss"
	use X || myconf="${EXTRA_CONF} --without-x"
	use png || myconf="${EXTRA_CONF} --without-pngdriver"

	econf ${myconf}
	# Do not install the JEMBOSS component (the --without-java configure option
	# does not work). JEMBOSS will eventually be available as a separate package.
	sed -i -e 's/SUBDIRS = plplot ajax nucleus emboss test doc jemboss/SUBDIRS = plplot ajax nucleus emboss test doc/' \
			Makefile || die
	emake || die
}

src_install() {
	einstall || die "Failed to install program files."

	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS "${FILESDIR}"/README.Gentoo \
			|| die "Failed to install documentation."

	# Install env file for setting libplplot and acd files path.
	doenvd "${FILESDIR}"/22emboss || die "Failed to install environment file."

	# Symlink preinstalled docs to /usr/share/doc.
	dosym /usr/share/EMBOSS/doc/manuals /usr/share/doc/${PF}/manuals || die
	dosym /usr/share/EMBOSS/doc/programs /usr/share/doc/${PF}/programs || die
	dosym /usr/share/EMBOSS/doc/tutorials /usr/share/doc/${PF}/tutorials || die
	dosym /usr/share/EMBOSS/doc/html /usr/share/doc/${PF}/html || die

	# Clashes #330507
	mv "${ED}"/usr/bin/{digest,pepdigest} || die

	# Remove useless dummy files from the image.
	find emboss/data -name dummyfile -delete || die "Failed to remove dummy files."

	# Move the provided codon files to a different directory. This will avoid
	# user confusion and file collisions on case-insensitive file systems (see
	# bug #115446). This change is documented in "README.Gentoo".
	mv "${ED}"/usr/share/EMBOSS/data/CODONS{,.orig} || \
			die "Failed to move CODON directory."

	# Move the provided restriction enzyme prototypes file to a different name.
	# This will avoid file collisions with future versions of rebase that will
	# install their own enzyme prototypes file (see bug #118832).
	mv "${ED}"/usr/share/EMBOSS/data/embossre.equ{,.orig} || \
			die "Failed to move enzyme equivalence file."
}
