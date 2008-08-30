# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/axiom/axiom-200803.ebuild,v 1.2 2008/08/30 13:17:33 markusle Exp $

inherit eutils multilib flag-o-matic

DESCRIPTION="Axiom is a general purpose Computer Algebra system"
HOMEPAGE="http://axiom.axiom-developer.org/"
SRC_URI="http://www.axiom-developer.org/axiom-website/downloads/${PN}-mar2008-src.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# NOTE: Do not strip since this seems to remove some crucial
# runtime paths as well, thereby, breaking axiom
RESTRICT="strip"

DEPEND="virtual/latex-base
	sys-apps/debianutils
	x11-libs/libXaw"

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp "${FILESDIR}"/noweb-2.9-insecure-tmp-file.patch.input \
		"${S}"/zips/noweb-2.9-insecure-tmp-file.patch \
		|| die "Failed to fix noweb"
	cp "${FILESDIR}"/${PN}-200711-gcl-configure.patch \
		"${S}"/zips/gcl-2.6.7.configure.in.patch \
		|| die "Failed to fix gcl-2.6.7 configure"
	epatch "${FILESDIR}"/noweb-2.9-insecure-tmp-file.Makefile.patch \
		|| die "Failed to patch noweb security issue!"
}

src_compile() {
	# lots of strict-aliasing badness
	append-flags -fno-strict-aliasing

	./configure || die "Failed to configure"
	# use gcl 2.6.7
	sed -e "s:GCLVERSION=gcl-2.6.8pre$:GCLVERSION=gcl-2.6.7:" \
		-i Makefile.pamphlet Makefile \
		|| die "Failed to select proper gcl"

	# fix libXpm.a location
	sed -e "s:X11R6/lib:$(get_libdir):g" -i Makefile.pamphlet \
		|| die "Failed to fix libXpm lib paths"

	# Let the fun begin...
	AXIOM="${S}"/mnt/linux emake -j1 || die
}

src_install() {
	make DESTDIR="${D}"/opt/axiom COMMAND="${D}"/opt/axiom/mnt/linux/bin/axiom install \
		|| die 'Failed to install Axiom!'

	mv "${D}"/opt/axiom/mnt/linux/* "${D}"/opt/axiom
	rm -fr "${D}"/opt/axiom/mnt

	dodir /usr/bin
	dosym /opt/axiom/bin/axiom /usr/bin/axiom

	sed -e "2d;3i AXIOM=/opt/axiom" \
		-i "${D}"/opt/axiom/bin/axiom \
		|| die "Failed to patch axiom runscript!"

	dodoc changelog readme faq
}
