# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vienna-rna/vienna-rna-1.7.0.ebuild,v 1.1 2008/05/01 13:13:57 markusle Exp $

inherit toolchain-funcs multilib eutils versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="The Vienna RNA Package - RNA secondary structure prediction and comparison"
LICENSE="vienna-rna"
HOMEPAGE="http://www.tbi.univie.ac.at/~ivo/RNA"
SRC_URI="http://www.tbi.univie.ac.at/~ivo/RNA/ViennaRNA-${MY_PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND="dev-lang/perl
	media-libs/gd"

S="${WORKDIR}/ViennaRNA-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.6.5-c-fixes.patch
}

src_compile() {
	econf --with-cluster || die "Configuration failed."
	sed -e "s:LIBDIR = /usr/lib:LIBDIR = ${D}/usr/$(get_libdir):" \
		-e "s:INCDIR = /usr/include:INCDIR = ${D}/usr/include:" \
		-i RNAforester/g2-0.70/Makefile \
			|| die "Failed patching RNAForester build system."
	emake || die "Compilation failed."

	cd "${S}"/Readseq
	sed -e "s:CC=cc:CC=$(tc-getCC):" -e "s:CFLAGS=:CFLAGS=${CFLAGS}:" \
		-i Makefile || die "Failed patching readseq Makefile."
	make || die "Failed to compile readseq."
	# TODO: Add (optional?) support for the NCBI toolkit.
}

src_install() {
	make install DESTDIR="${D}" || die "Installation failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS \
		|| die "Failed to install documentation."
	newbin Readseq/readseq readseq-vienna \
		|| die "Installing readseq failed."
	dodoc Readseq/Readseq.help || die \
		"Readseq Documentation installation failed."
	newdoc Readseq/Readme README.readseq && \
		newdoc Readseq/Formats Formats.readseq \
		|| die "Installing readseq Readme failed."
}
