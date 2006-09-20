# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/haproxy/haproxy-1.2.15.ebuild,v 1.1 2006/09/20 11:41:35 mrness Exp $

inherit linux-info

DESCRIPTION="A TCP/HTTP reverse proxy for high availability environments"
HOMEPAGE="http://haproxy.1wt.eu"
SRC_URI="http://haproxy.1wt.eu/download/1.2/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="pcre"

DEPEND="pcre? ( >=dev-libs/libpcre-6.3 )"

src_compile() {
	local ARGS="TARGET=linux${KV_MAJOR}${KV_MINOR}"
	use pcre && ARGS="${ARGS} REGEX=pcre"
	emake ADDINC="${CFLAGS}" LDFLAGS="${LDFLAGS}" ${ARGS}
}

src_install() {
	exeinto /usr/bin
	doexe haproxy
	newinitd "${FILESDIR}/haproxy.initd" haproxy

	dodoc CHANGELOG ROADMAP TODO doc/*
	docinto examples
	dodoc examples/examples.cfg examples/haproxy.cfg
}

pkg_postinst() {
	if [[ ! -f "${ROOT}/etc/haproxy.cfg" ]] ; then
		einfo "You need to create /etc/haproxy.cfg before you start haproxy service."
		if [[ -d "${ROOT}/usr/share/doc/${P}" ]]; then
			einfo "Please consult the installed documentation for learning the configuration file's syntax."
			einfo "The documentation and sample configuration files are installed here:"
			einfo "   ${ROOT}usr/share/doc/${P}"
		fi
	fi
}
