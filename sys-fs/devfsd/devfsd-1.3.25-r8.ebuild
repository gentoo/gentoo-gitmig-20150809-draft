# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/devfsd/devfsd-1.3.25-r8.ebuild,v 1.2 2004/04/06 03:17:56 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Daemon for the Linux Device Filesystem"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips hppa ~amd64 ia64 ppc64 s390"

DEPEND="virtual/glibc"
PROVIDE="virtual/dev-manager"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-kernel-2.5.patch
	epatch ${FILESDIR}/${P}-pic.patch

	sed -e "s:-O2:${CFLAGS}:g" \
		-e 's:/usr/man:/usr/share/man:' \
		-e '32,34d;11,16d' -e '6c\' \
		-e 'DEFINES	:= -DLIBNSL="\\"/lib/libnsl.so.1\\""' \
		-i GNUmakefile
}

src_compile() {
	make || die
}

src_install() {
	dodir /sbin /usr/share/man /etc
	make PREFIX=${D} install || die

	#config file is handled in baselayout
	rm -f ${D}/etc/devfsd.conf

	dodoc devfsd.conf INSTALL
}
