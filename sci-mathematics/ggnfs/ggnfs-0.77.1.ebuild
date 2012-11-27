# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ggnfs/ggnfs-0.77.1.ebuild,v 1.1 2012/11/27 13:32:51 patrick Exp $

EAPI=4
DESCRIPTION="A suite of algorithms to help factoring large integers"
# inactive old homepage exists, this is a fork
HOMEPAGE="https://github.com/radii/ggnfs"
# snapshot because github makes people stupid
SRC_URI="http://dev.gentooexperimental.org/~dreeevil/${P}.zip"

inherit eutils

LICENSE="GPL-2"
SLOT="0"
# Need to test if it actually compiles on x86
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!sci-mathematics/cado-nfs" # file collisions, fixable

S=${WORKDIR}/${PN}-master

src_prepare() {
	echo "#define GGNFS_VERSION \"0.77.1-$ARCH\"" > include/version.h
	# fix directory symlink, add missing targets, rewrite variable used by portage internally
	cd src/lasieve4 && rm -f -r asm && ln -s ppc32 asm || die
	sed -i -e 's/all: liblasieve.a/all: liblasieve.a liblasieveI11.a liblasieveI15.a liblasieveI16.a/' asm/Makefile || die
	cd "${S}"
	sed -i -e 's/ARCH/MARCH/g' Makefile src/Makefile || die
	sed -i -e 's/$(LSBINS) strip/$(LSBINS)/' src/Makefile || die #No stripping!
}

src_configure() { :; }

src_compile() {
	# setting MARCH like this is fugly, but it uses -march=$ARCH - better fix welcome
	# it also assumes a recent-ish compiler
	cd src
	HOST="generic" MARCH="native" emake
}

src_install() {
	mkdir -p "${D}/usr/bin/"
	for i in gnfs-lasieve4I11e gnfs-lasieve4I12e gnfs-lasieve4I13e gnfs-lasieve4I14e \
		gnfs-lasieve4I15e gnfs-lasieve4I16e makefb matbuild matprune matsolve pol51m0b pol51m0n \
		pol51opt polyselect procrels sieve sqrt; do
		cp "${S}/bin/${i}" "${D}/usr/bin/" || die
	done
	# TODO: docs? File collisions?
}
