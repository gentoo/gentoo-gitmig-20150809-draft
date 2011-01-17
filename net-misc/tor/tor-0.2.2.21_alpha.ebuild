# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.2.2.21_alpha.ebuild,v 1.1 2011/01/17 13:46:16 chiiph Exp $

EAPI=3

inherit eutils versionator

MY_PV="$(replace_version_separator 4 -)"
MY_PF="${PN}-${MY_PV}"
DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.torproject.org/"
SRC_URI="http://www.torproject.org/dist/${MY_PF}.tar.gz"
S="${WORKDIR}/${MY_PF}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

# libevent-2.0 is masked but we still depend on it
# See: bug #206969 and https://trac.torproject.org/projects/tor/ticket/920
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
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	newinitd "${FILESDIR}"/tor.initd-r4 tor
	emake DESTDIR="${D}" install || die
	keepdir /var/{lib,log,run}/tor

	dodoc README ChangeLog ReleaseNotes \
		doc/{HACKING,TODO} \
		doc/spec/*.txt

	fperms 750 /var/lib/tor /var/log/tor
	fperms 755 /var/run/tor
	fowners tor:tor /var/lib/tor /var/log/tor /var/run/tor

	insinto /etc/logrotate.d
	newins contrib/tor.logrotate tor

	# allow the tor user more open files to avoid errors, see bug 251171
	insinto /etc/security/limits.d/
	doins "${FILESDIR}"/tor.conf
}

pkg_postinst() {
	elog "You must create /etc/tor/torrc, you can use the sample that is in that directory"
	elog "To have privoxy and tor working together you must add:"
	elog "forward-socks4a / localhost:9050 ."
	elog "(notice the . at the end of the line)"
	elog "to /etc/privoxy/config"
}
