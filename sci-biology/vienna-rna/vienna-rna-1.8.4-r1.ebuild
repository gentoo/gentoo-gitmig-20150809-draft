# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vienna-rna/vienna-rna-1.8.4-r1.ebuild,v 1.1 2010/06/25 09:22:36 jlec Exp $

EAPI="2"

inherit toolchain-funcs multilib autotools perl-module

DESCRIPTION="The Vienna RNA Package - RNA secondary structure prediction and comparison"
LICENSE="vienna-rna"
HOMEPAGE="http://www.tbi.univie.ac.at/~ivo/RNA"
SRC_URI="http://www.tbi.univie.ac.at/~ivo/RNA/ViennaRNA-${PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-lang/perl
	media-libs/gd"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ViennaRNA-${PV}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.6.5-c-fixes.patch
	"${FILESDIR}"/${PN}-1.7.2-LDFLAGS.patch
	"${FILESDIR}"/${PN}-1.8.3-gcc4.3.patch
	"${FILESDIR}"/${PN}-1.8.3-disable-gd.patch
	"${FILESDIR}"/${P}-jobserver-fix.patch
	"${FILESDIR}"/${P}-bindir.patch
)

src_prepare() {
	base_src_prepare
	sed -i 's/ getline/ v_getline/' Readseq/ureadseq.c || die
	sed -i '1 i #include <cstdio>' RNAforester/src/rnafuncs.cpp || die

	eautoreconf
	(cd RNAforester; eautoreconf)
}

src_configure() {
	econf --with-cluster || die "Configuration failed."
	sed -e "s:LIBDIR = /usr/lib:LIBDIR = ${D}/usr/$(get_libdir):" \
		-e "s:INCDIR = /usr/include:INCDIR = ${D}/usr/include:" \
		-i RNAforester/g2-0.70/Makefile \
			|| die "Failed patching RNAForester build system."
	sed -e "s:CC=cc:CC=$(tc-getCC):" -e "s:CFLAGS=:CFLAGS=${CFLAGS}:" \
		-i Readseq/Makefile || die "Failed patching readseq Makefile."
}

src_compile() {
	emake clean || die
	emake || die "Compilation failed."
	emake -C Readseq || die "Failed to compile readseq."
	# TODO: Add (optional?) support for the NCBI toolkit.
}

src_test() {
	cd "${S}"/Perl && emake check || die "Perl tests failed"
	cd "${S}"/Readseq && emake test || die "Readseq tests failed"
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

	# remove perlocal.pod to avoid file collisions (see #240358)
	fixlocalpod || die "Failed to remove perlocal.pod"
}
