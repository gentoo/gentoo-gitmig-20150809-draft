# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/haproxy/haproxy-1.3.8.ebuild,v 1.1 2007/03/30 08:47:21 mrness Exp $

inherit linux-info

DESCRIPTION="A TCP/HTTP reverse proxy for high availability environments"
HOMEPAGE="http://haproxy.1wt.eu"
SRC_URI="http://haproxy.1wt.eu/download/${PV%.*}/src/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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

	# Don't install useless files
	rm examples/build.cfg doc/*gpl.txt

	dodoc CHANGELOG ROADMAP TODO doc/*.txt
	docinto examples
	dodoc examples/*.cfg
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
