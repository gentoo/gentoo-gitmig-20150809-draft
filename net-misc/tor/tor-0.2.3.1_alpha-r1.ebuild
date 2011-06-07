# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.2.3.1_alpha-r1.ebuild,v 1.1 2011/06/07 22:02:29 blueness Exp $

EAPI=3

inherit autotools eutils flag-o-matic versionator

MY_PV="$(replace_version_separator 4 -)"
MY_PF="${PN}-${MY_PV}"
DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.torproject.org/"
SRC_URI="http://www.torproject.org/dist/${MY_PF}.tar.gz"
S="${WORKDIR}/${MY_PF}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/openssl
	>=dev-libs/libevent-2.0"
# The tordns patch for tsocks avoids some leakage of information thus raising anonymity
RDEPEND="${DEPEND}
	net-proxy/tsocks[tordns]"

pkg_setup() {
	enewgroup tor
	enewuser tor -1 -1 /var/lib/tor tor
}

src_prepare() {
	epatch "${FILESDIR}"/torrc.sample-0.1.2.6.patch
	epatch "${FILESDIR}"/${PN}-0.2.1.19-logrotate.patch

	einfo "Regenerating autotools files ..."
	epatch "${FILESDIR}"/${PN}-0.2.2.24_alpha-respect-CFLAGS.patch
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	# Upstream isn't sure of all the user provided CFLAGS that
	# will break tor, but does recommend against -fstrict-aliasing.
	# We'll filter-flags them here as we encounter them.
	filter-flags -fstrict-aliasing
	econf --docdir=/usr/share/doc/${PF}
}

src_install() {
	newconfd "${FILESDIR}"/tor.confd tor
	newinitd "${FILESDIR}"/tor.initd-r4 tor
	emake DESTDIR="${D}" install || die
	keepdir /var/{lib,log,run}/tor

	dodoc README ChangeLog ReleaseNotes \
		doc/{HACKING,TODO} \
		doc/spec/README

	fperms 750 /var/lib/tor /var/log/tor
	fperms 755 /var/run/tor
	fowners tor:tor /var/lib/tor /var/log/tor /var/run/tor

	insinto /etc/tor/
	doins "${FILESDIR}"/torrc

	insinto /etc/logrotate.d
	newins contrib/tor.logrotate tor
}

pkg_postinst() {
	elog
	elog "We created a configuration file for tor, /etc/tor/torrc, but you can"
	elog "change it according to your needs.  Use the torrc.sample that is in"
	elog "that directory as a guide.  Also, to have privoxy work with tor"
	elog "just add the following line"
	elog
	elog "forward-socks4a / localhost:9050 ."
	elog
	elog "to /etc/privoxy/config.  Notice the . at the end!"
	elog
}
