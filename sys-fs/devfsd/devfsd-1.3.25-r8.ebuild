# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/devfsd/devfsd-1.3.25-r8.ebuild,v 1.13 2004/12/08 02:04:30 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Daemon for the Linux Device Filesystem"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="uclibc"

DEPEND="virtual/libc"
PROVIDE="virtual/dev-manager"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-kernel-2.5.patch
	epatch ${FILESDIR}/${P}-pic.patch
	epatch ${FILESDIR}/${P}-no-nis.patch

	use uclibc || append-flags -DHAVE_NIS
	sed -e "s:-O2:${CFLAGS}:g" \
		-e 's:/usr/man:/usr/share/man:' \
		-e 's:/usr/src/linux:.:' \
		-e '32,34d;11,16d' -e '6c\' \
		-e 'DEFINES	:= -DLIBNSL="\\"/lib/libnsl.so.1\\""' \
		-e 's:install -s:install:' \
		-i GNUmakefile
	use uclibc && sed -e 's|libnsl.so.1|libnsl.so.0|' -i GNUmakefile
	tc-export CC
}

src_install() {
	dodir /sbin /usr/share/man /etc
	make PREFIX=${D} install || die
	dodoc devfsd.conf INSTALL

	dodir /etc/devfs.d
	insinto /etc
	doins ${FILESDIR}/devfsd.conf
}
