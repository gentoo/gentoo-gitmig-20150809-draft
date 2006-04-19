# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conserver/conserver-8.1.14.ebuild,v 1.1 2006/04/19 02:59:58 weeve Exp $

inherit ssl-cert eutils

DESCRIPTION="Serial Console Manager"
HOMEPAGE="http://www.conserver.com/"
SRC_URI="ftp://ftp.conserver.com/conserver/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 -ia64 ~ppc ~sparc ~x86"
IUSE="pam ssl tcpd debug"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6g )
	pam? ( virtual/pam )
	tcpd? ( sys-apps/tcp-wrappers )
	!amd64? ( debug? ( dev-libs/dmalloc ) )"

src_compile() {
	use amd64 && \
		einfo "debug use flag is disabled on amd64 since deps cannot be met."

	econf \
		$(use_with ssl openssl) \
		$(use_with pam) \
		$(use_with tcpd libwrap) \
		$(use_with debug dmalloc) \
		--with-logfile=/var/log/conserver.log \
		--with-pidfile=/var/run/conserver.pid \
		--with-cffile=conserver/conserver.cf \
		--with-pwdfile=conserver/conserver.passwd \
		--with-master=localhost \
		--with-port=7782 || die "./configure failed"

	emake || die "compile failed"
}

src_install() {
	einstall exampledir=${D}/usr/share/doc/${PF}/examples \
		|| die "problem with install"

	## create data directory
	dodir /var/consoles
	fowners daemon:daemon /var/consoles
	fperms 700 /var/consoles

	## add startup and sample config
	newinitd ${FILESDIR}/conserver.initd conserver
	newconfd ${FILESDIR}/conserver.confd conserver

	dodir /etc/conserver
	fperms 700 /etc/conserver
	insinto /etc/conserver
	newins ${S}/conserver.cf/conserver.cf conserver.cf.sample
	newins ${S}/conserver.cf/conserver.passwd conserver.passwd.sample

	## add docs
	dohtml conserver.html
	dodoc CHANGES FAQ INSTALL LICENSE README TODO
	dodoc conserver/Sun-serial conserver.cf/INSTALL
	dodoc contrib/maketestcerts
	newdoc conserver.cf/conserver.cf conserver.cf.sample

	# Add pam config
	newpamd ${FILESDIR}/conserver.pam-include conserver

	# Add certs if SSL use flag is enabled
	if use ssl && [ ! -f /etc/ssl/conserver/conserver.key ]; then
		dodir /etc/ssl/conserver
		insinto /etc/ssl/conserver
		docert conserver
	fi
}

pkg_postinst() {
	einfo "Config-file formats _changed_ with version 8.0 !"
}
