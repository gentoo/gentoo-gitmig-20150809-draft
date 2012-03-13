# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/dante/dante-1.2.3.ebuild,v 1.2 2012/03/13 12:07:02 phajdan.jr Exp $

EAPI=4

inherit eutils

DESCRIPTION="A free socks4,5 and msproxy implementation"
HOMEPAGE="http://www.inet.no/dante/"
SRC_URI="ftp://ftp.inet.no/pub/socks/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug kerberos pam selinux static-libs tcpd"

RDEPEND="pam? ( virtual/pam )
	kerberos? ( virtual/krb5 )
	selinux? ( sec-policy/selinux-dante )
	tcpd? ( sys-apps/tcp-wrappers )
	userland_GNU? ( virtual/shadow )"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

DOCS="BUGS CREDITS NEWS README SUPPORT TODO doc/README* doc/*.txt doc/SOCKS4.protocol"

src_prepare() {
	epatch "${FILESDIR}/${P}-socksify.patch"

	sed -i \
		-e 's:/etc/socks\.conf:/etc/socks/socks.conf:' \
		-e 's:/etc/sockd\.conf:/etc/socks/sockd.conf:' \
		doc/{socksify.1,socks.conf.5,sockd.conf.5,sockd.8}
}

src_configure() {
	econf \
		--with-socks-conf=/etc/socks/socks.conf \
		--with-sockd-conf=/etc/socks/sockd.conf \
		--without-upnp \
		$(use_enable debug) \
		$(use_with kerberos gssapi) \
		$(use_with pam) \
		$(use_enable static-libs static) \
		$(use_enable tcpd libwrap)
}

src_install() {
	default

	# default configuration files
	insinto /etc/socks
	doins "${FILESDIR}"/sock?.conf
	pushd "${D}/etc/socks" > /dev/null
	use pam && epatch "${FILESDIR}/sockd.conf-with-pam.patch"
	use tcpd && epatch "${FILESDIR}/sockd.conf-with-libwrap.patch"
	popd > /dev/null

	# init script
	newinitd "${FILESDIR}/dante-sockd-init" dante-sockd
	newconfd "${FILESDIR}/dante-sockd-conf" dante-sockd

	# example configuration files
	docinto examples
	dodoc example/*.conf

	use static-libs || find "${ED}" -name '*.la' -exec rm '{}' +
}

pkg_postinst() {
	enewuser sockd -1 -1 /etc/socks daemon
}
