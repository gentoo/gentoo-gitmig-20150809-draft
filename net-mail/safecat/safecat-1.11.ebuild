# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/safecat/safecat-1.11.ebuild,v 1.2 2003/09/05 09:13:50 msterret Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="Safecat implements qmail's maildir algorithm, copying standard input safely to a specified directory."
HOMEPAGE="http://budney.homeunix.net:8080/users/budney/linux/software/${PN}/"
SRC_URI="http://budney.homeunix.net:8080/users/budney/linux/software/${PN}/${P}.tar.gz"

DEPEND="virtual/glibc
	sys-apps/groff"

RDEPEND="virtual/glibc"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc"

src_unpack() {
	unpack ${P}.tar.gz

	# applying errno-patch and maildir-patch
	epatch ${FILESDIR}/safecat-1.11-gentoo.patch

	cd ${S}
	echo "/usr" > conf-root
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld

}

src_compile() {
	grep -v man hier.c | grep -v doc > hier.c
	make it man || die
}

src_install() {
	dodir /usr
	echo "${D}/usr" > conf-root
	make man setup check || die
	dodoc CHANGES COPYING INSTALL README
	doman maildir.1 safecat.1
}

