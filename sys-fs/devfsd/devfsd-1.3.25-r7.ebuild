# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/devfsd/devfsd-1.3.25-r7.ebuild,v 1.2 2004/04/06 03:17:56 vapier Exp $

IUSE=""

inherit eutils flag-o-matic

S="${WORKDIR}/${PN}"
DESCRIPTION="Daemon for the Linux Device Filesystem"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~mips ~hppa ia64"

DEPEND="virtual/glibc"

PROVIDE="virtual/dev-manager"

src_unpack() {
	unpack ${A}

	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml or #gentoo-hardened/irc.freenode
	has_version "sys-devel/hardened-gcc" && append-flags "-yet_exec"

	cd ${S}
	epatch ${FILESDIR}/${P}-kernel-2.5.patch.bz2

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

	dodoc devfsd.conf COPYING* INSTALL
}
