# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.2.2.35-r1.ebuild,v 1.2 2012/03/08 16:14:22 blueness Exp $

EAPI="4"

inherit autotools eutils flag-o-matic

DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.torproject.org/"
SRC_URI="http://www.torproject.org/dist/${PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="tor-hardening +transparent-proxy threads selinux"

DEPEND="dev-libs/openssl
	>=dev-libs/libevent-2.0
	selinux? ( sec-policy/selinux-tor )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup tor
	enewuser tor -1 -1 /var/lib/tor tor
}

src_prepare() {
	epatch "${FILESDIR}"/torrc.sample.patch

	einfo "Regenerating autotools files ..."
	epatch "${FILESDIR}"/${PN}-0.2.2.24_alpha-respect-CFLAGS.patch
	eautoreconf
}

src_configure() {
	# Upstream isn't sure of all the user provided CFLAGS that
	# will break tor, but does recommend against -fstrict-aliasing.
	# We'll filter-flags them here as we encounter them.
	filter-flags -fstrict-aliasing
	econf \
		--enable-asciidoc \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable tor-hardening gcc-hardening)	\
		$(use_enable tor-hardening linker-hardening)\
		$(use_enable transparent-proxy transparent)	\
		$(use_enable threads)
}

src_install() {
	newconfd "${FILESDIR}"/tor.confd tor
	newinitd "${FILESDIR}"/tor.initd-r6 tor
	emake DESTDIR="${D}" install
	keepdir /var/lib/tor

	dodoc README ChangeLog ReleaseNotes \
		doc/{HACKING,TODO} \
		doc/spec/README

	fperms 750 /var/lib/tor
	fowners tor:tor /var/lib/tor

	insinto /etc/tor/
	newins "${FILESDIR}"/torrc-r1 torrc
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
