# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conserver/conserver-8.0.9.ebuild,v 1.4 2004/01/23 14:46:46 agriffis Exp $

DESCRIPTION="Conserver - Serial Console Manager"
HOMEPAGE="http://www.conserver.com/"
SRC_URI="ftp://ftp.conserver.com/conserver/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc alpha ia64"

IUSE="pam ssl tcpd"
DEPEND="ssl?  ( >=dev-libs/openssl-0.9.6g )
	pam?  ( sys-libs/pam )
	tcpd? ( sys-apps/tcp-wrappers )"

src_compile() {
	econf \
		$(use_with ssl openssl) \
		$(use_with pam) \
		$(use_with tcpd libwrap) \
		--with-logfile=/var/log/conserver.log \
		--with-pidfile=/var/run/conserver.pid \
		--with-cffile=conserver/conserver.cf \
		--with-pwdfile=conserver/conserver.passwd \
		--with-master=localhost \
		--with-port=7782 || die "./configure failed"

	emake || die "compile failed"
}

src_install () {
	einstall exampledir=${D}/usr/share/doc/${PF}/examples || die "problem with install"

	## create data directory
	dodir /var/consoles
	fowners daemon:daemon /var/consoles
	fperms 700 /var/consoles

	## add startup and sample config
	exeinto /etc/init.d
	newexe ${FILESDIR}/conserver.initd conserver
	insinto /etc/conf.d
	newins ${FILESDIR}/conserver.confd conserver

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
	insinto /etc/pam.d ; newins ${FILESDIR}/conserver.pam conserver
}

pkg_postinst() {
	einfo "Config-file formats _changed_ with version 8.0 !"
	if use ssl; then
		einfo "You will need to create certificates to use the ssl-feature."
	fi
}
