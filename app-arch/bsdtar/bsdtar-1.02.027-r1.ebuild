# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdtar/bsdtar-1.02.027-r1.ebuild,v 1.4 2005/07/28 15:29:32 flameeyes Exp $

inherit eutils flag-o-matic

DESCRIPTION="BSD tar command"
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive/"
SRC_URI="http://people.freebsd.org/~kientzle/libarchive/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc-macos ~x86"
IUSE="build static"

# This is told to be used ( !elibc_glibc? ( dev-libs/libgnugetopt ) ) but isn't
# linked at all
RDEPEND="app-arch/bzip2
	sys-libs/zlib"

DEPEND="~dev-libs/libarchive-${PV}
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-osx.patch
}

src_compile() {
	( use static || use build ) && append-ldflags -static

	econf --bindir=/bin || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install

	# Create tar symlink for BSD userlands
	if [[ ${USERLAND} == "BSD" ]]; then
		dosym bsdtar /bin/tar
		dosym bsdtar.1.gz /usr/share/man/man1/tar.1.gz
	fi
}
