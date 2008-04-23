# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/siproxd/siproxd-0.7.0.ebuild,v 1.2 2008/04/23 21:26:50 maekke Exp $

inherit eutils autotools

DESCRIPTION="masquerading SIP proxy"
HOMEPAGE="http://siproxd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static doc"

DEPEND=">=net-libs/libosip-3.1
	doc? ( app-text/docbook-sgml-utils ~app-text/docbook-sgml-dtd-4.2 )"

pkg_setup() {
	enewgroup siproxd
	enewuser siproxd -1 -1 /dev/null siproxd
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.5.11-configure-docs.diff
	epatch "${FILESDIR}"/${P}-guide.diff
	epatch "${FILESDIR}"/${P}-libosip-3.1.0.diff

	eautoreconf || die "autoreconf failed"

	# Make the daemon run as user 'siproxd' by default
	sed -i -e "s:nobody:siproxd:" doc/siproxd.conf.example
}

src_compile() {
	econf \
		$(use_enable doc docs) \
		$(use static && use_enable static) \
		|| die "configure failed"
		# --disable-static won't work, see bug 205765
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}"/siproxd.rc6 siproxd || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO RELNOTES

	# Set up siproxd directories
	keepdir /var/{lib,run}/siproxd
	fowners siproxd:siproxd /var/{lib,run}/siproxd
}
