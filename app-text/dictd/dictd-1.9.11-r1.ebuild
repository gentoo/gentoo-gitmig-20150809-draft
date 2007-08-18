# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.9.11-r1.ebuild,v 1.13 2007/08/18 01:15:54 philantrop Exp $

DESCRIPTION="Dictionary Client/Server for the DICT protocol"
HOMEPAGE="http://www.dict.org/"
SRC_URI="mirror://sourceforge/dict/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha ~hppa ~mips amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf \
		--with-cflags="${CFLAGS}" \
		--sysconfdir=/etc/dict || die
	make || die
}

src_install() {
	# Now install it.
	make DESTDIR="${D}" install || die "install failed"

	# Install docs
	dodoc README TODO COPYING ChangeLog ANNOUNCE
	dodoc doc/dicf.ms doc/rfc.ms doc/rfc.sh doc/rfc2229.txt
	dodoc doc/security.doc doc/toc.ms

	# conf files.
	dodir /etc/dict
	insinto /etc/dict
	doins "${FILESDIR}"/${PVR}/dict.conf
	doins "${FILESDIR}"/${PVR}/dictd.conf
	doins "${FILESDIR}"/${PVR}/site.info

	# startups for dictd
	newinitd "${FILESDIR}"/${PVR}/dictd dictd
	newconfd "${FILESDIR}"/${PVR}/dictd.confd dictd

	# Remove useless cruft, fixes bug 107376
	rm -f ${D}/usr/bin/colorit
	rm -f ${D}/usr/share/man/man1/colorit.1
}
