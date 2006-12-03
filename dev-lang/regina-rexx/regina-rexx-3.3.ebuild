# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/regina-rexx/regina-rexx-3.3.ebuild,v 1.8 2006/12/03 03:25:50 vapier Exp $

DESCRIPTION="Portable Rexx interpreter"
HOMEPAGE="http://regina-rexx.sourceforge.net"
SRC_URI="mirror://sourceforge/regina-rexx/Regina-REXX-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 hppa ~ppc s390 ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/Regina-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	autoconf || die "autoconf problem"
}

src_compile() {
	econf || die "econf failed"
	sed -i \
		-e 's|-$(INSTALL) -m 755 -c ./rxstack.init.d $(STARTUPDIR)/rxstack||' \
		-e "s|/usr/share/regina|${D}/usr/share/regina|" \
		Makefile || die
	emake CFLAGS="${CFLAGS} -fno-strict-aliasing" -j1 || die "make problem"
}

src_install() {
	einstall datadir="${D}"/usr/share/regina || die
	rm -rf "${D}"/etc/rc.d

	newinitd "${FILESDIR}"/rxstack

	dodoc BUGS HACKERS.txt README.Unix README_SAFE TODO
}

pkg_postinst() {
	einfo "You may want to run"
	einfo
	einfo "\trc-update add rxstack default"
	einfo
	einfo "to enable Rexx queues (optional)."
}
