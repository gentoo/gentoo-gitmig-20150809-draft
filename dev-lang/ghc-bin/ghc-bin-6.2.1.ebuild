# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc-bin/ghc-bin-6.2.1.ebuild,v 1.2 2004/10/18 22:54:07 kosmikus Exp $

IUSE=""

S="${WORKDIR}"
DESCRIPTION="Glasgow Haskell Compiler (binary-only version for amd64)"
SRC_URI="http://debian-amd64.alioth.debian.org/pure64/pool/unstable/main/amd64/g/ghc6/ghc6_6.2.1-5_amd64.deb"
HOMEPAGE="http://www.haskell.org"

LICENSE="as-is"
KEYWORDS="-* ~amd64"
SLOT="0"

DEPEND="app-arch/dpkg"
RDEPEND=">=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=dev-libs/gmp-4.1"

PROVIDE="virtual/ghc"

src_unpack() {
	for i in ${A}; do
		dpkg -x ${DISTDIR}/${i} .
	done
}

src_install () {
	# Copy it
	mkdir -p ${D}/opt/ghc
	for i in lib share; do
		cp -rl usr/$i/ghc-6.2.1 ${D}/opt/ghc/$i
	done

	# Provide package.conf
	pushd ${D}/opt/ghc/lib
	cp -a package.conf.shipped package.conf
	popd

	# Generate symlinks in ${D}/opt/ghc/bin
	mkdir -p ${D}/opt/ghc/bin
	pushd ${D}/opt/ghc/bin
	ln -s ../lib/bin/ghc ghc-${PV}
	ln -s ../lib/bin/ghci ghci-${PV}
	ln -s ghc-${PV} ghc
	ln -s ghci-${PV} ghci
	popd

	# TODO: what about documentation
	# TODO: can clean_wrappers be reused from the other ghc-bin
	# ebuilds; isn't RDEPEND perl needed if we call perl here?

	# Adjust paths in ${D}/opt/ghc/lib/bin
	pushd ${D}/opt/ghc/lib/bin
	perl -i -ne "s:/usr/lib/ghc-${PV}:/opt/ghc/lib:g;
			 s:/usr/share/ghc-${PV}:/opt/ghc/share:g;print" \
		ghc-${PV} ghci-${PV} ghcprof hsc2hs ghc-pkg-${PV}
	popd

	insinto /etc/env.d
	doins ${FILESDIR}/10ghc

}
