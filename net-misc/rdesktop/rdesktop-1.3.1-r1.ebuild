# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.3.1-r1.ebuild,v 1.5 2004/10/20 03:45:57 weeve Exp $

inherit eutils

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ia64 ppc64 amd64"
IUSE="kde ssl debug"

DEPEND="virtual/x11
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_unpack() {
	unpack ${A}

	# Apply KDE 3.3.0 compatibility patch from KDE CVS submitted to bug #58312
	# by Ronald Moesbergen <r.moesbergen@hccnet.nl>
	use kde && epatch ${FILESDIR}/${P}-kde.patch
}

src_compile() {
	local myconf
	use ssl \
		&& myconf="--with-openssl=/usr/include/openssl" \
		|| myconf="--without-openssl"

	sed -i -e '/-O2/c\' -e 'cflags="$cflags ${CFLAGS}"' configure

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sharedir=/usr/share/${PN} \
		`use_with debug` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
