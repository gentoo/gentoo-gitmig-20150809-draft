# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/squirm/squirm-1.23.ebuild,v 1.4 2004/09/03 16:06:50 pvdabeel Exp $

DESCRIPTION="A redirector for Squid"
HOMEPAGE="http://squirm.foote.com.au"
SRC_URI="http://squirm.foote.com.au/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=""
RDEPEND="www-proxy/squid"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die
	mv Makefile Makefile.orig
	sed -e 's|^EXTRALIBS=.*|EXTRALIBS=|' \
		-e 's|^PREFIX=.*|PREFIX=/usr/squirm|' \
		-e "s|^OPTIMISATION=.*|OPTIMISATION=${CFLAGS}|" \
		-e "s|^CFLAGS =.*|CFLAGS=${CFLAGS} -DPREFIX=\\\\\"\$(PREFIX)\\\\\"|" Makefile.orig > Makefile
}

src_compile() {
	cd ${S}
	emake || die "make failed"
}

src_install() {
	make PREFIX=${D}/usr/squirm install || die "make install failed"
}

pkg_postinst() {
	einfo "To enable squirm add the following lines to squid.conf:"
	einfo "redirect_program /usr/squirm/bin/squirm"
	einfo "redirect_children 10"
}
