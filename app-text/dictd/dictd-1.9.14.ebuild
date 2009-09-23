# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd/dictd-1.9.14.ebuild,v 1.18 2009/09/23 16:32:47 patrick Exp $

DESCRIPTION="Dictionary Client/Server for the DICT protocol"
HOMEPAGE="http://www.dict.org/"
SRC_URI="mirror://sourceforge/dict/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

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
	dodoc README TODO ChangeLog ANNOUNCE
	dodoc doc/dicf.ms doc/rfc.ms doc/rfc.sh doc/rfc2229.txt
	dodoc doc/security.doc doc/toc.ms

	# conf files.
	dodir /etc/dict
	insinto /etc/dict
	doins "${FILESDIR}"/1.9.11-r1/dict.conf
	doins "${FILESDIR}"/1.9.11-r1/dictd.conf
	doins "${FILESDIR}"/1.9.11-r1/site.info

	# startups for dictd
	newinitd "${FILESDIR}"/1.9.11-r1/dictd dictd
	newconfd "${FILESDIR}"/1.9.11-r1/dictd.confd dictd

	# Remove useless cruft, fixes bug 107376
	rm -f "${D}"/usr/bin/colorit
	rm -f "${D}"/usr/share/man/man1/colorit.1
}
