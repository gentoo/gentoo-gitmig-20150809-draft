# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/pound/pound-1.7.ebuild,v 1.2 2004/09/03 15:58:51 pvdabeel Exp $

MY_P=${P/p/P}

DESCRIPTION="A http/https reverse-proxy and load-balancer."
SRC_URI="http://www.apsis.ch/pound/${MY_P}.tgz"
HOMEPAGE="http://www.apsis.ch/pound/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~mips ~hppa"
IUSE="ssl msdav unsafe"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf

	## check for ssl-support:
	myconf="${myconf} `use_with ssl` `use_enable msdav` `use_enable unsafe`"

	econf ${myconf} || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	dosbin pound
	doman pound.8

	dodoc README

	exeinto /etc/init.d
	newexe ${FILESDIR}/pound.init pound

	insinto /etc
	doins ${FILESDIR}/pound.cfg
}

pkg_postinst() {
	einfo "No demo-/sample-configfile is included in the distribution -- read the man-page"
	einfo "for more info."
	einfo "A sample (localhost:8888 -> localhost:80) for gentoo is given in \"/etc/pound.cfg\"."
}
