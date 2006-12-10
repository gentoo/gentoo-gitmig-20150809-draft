# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/pound/pound-1.10.ebuild,v 1.3 2006/12/10 09:34:17 beu Exp $

inherit flag-o-matic

MY_P="${P/p/P}"
DESCRIPTION="A http/https reverse-proxy and load-balancer."
SRC_URI="http://www.apsis.ch/pound/${MY_P}.tgz"
HOMEPAGE="http://www.apsis.ch/pound/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~amd64"
IUSE="ssl msdav unsafe static"

DEPEND="ssl? ( dev-libs/openssl )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	use static && append-ldflags -static

	econf \
		$(use_with ssl) \
		$(use_enable msdav) \
		$(use_enable unsafe) \
		|| die "configure failed"

	emake || die "compile failed"
}

src_install() {
	dosbin pound
	doman pound.8

	dodoc README FAQ

	newinitd ${FILESDIR}/${PN}.init-1.9 ${PN}

	insinto /etc
	doins ${FILESDIR}/pound.cfg
}

pkg_postinst() {
	einfo "No demo-/sample-configfile is included in the distribution -- read the man-page"
	einfo "for more info."
	einfo "A sample (localhost:8888 -> localhost:80) for gentoo is given in \"/etc/pound.cfg\"."
}
