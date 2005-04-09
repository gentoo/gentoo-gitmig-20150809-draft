# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ssl/mod_ssl-2.8.22-r1.ebuild,v 1.1 2005/04/09 15:28:14 hollow Exp $

inherit apache-module

MY_P=${P}-1.3.33

DESCRIPTION="An SSL module for the Apache Web server"
HOMEPAGE="http://www.modssl.org/"
SRC_URI="http://www.modssl.org/source/${MY_P}.tar.gz"

KEYWORDS="~x86 ~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~ppc64"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6k"

S=${WORKDIR}/${MY_P}

APACHE1_MOD_FILE="${S}/pkg.sslmod/libssl.so"
APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="SSL"

VHOSTFILE="default-ssl"

DOCFILES="ANNOUNCE CHANGES CREDITS LICENSE NEWS README*"

need_apache1

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	# proper path to openssl
	sed -i -e 's:^\(openssl=\).*:\1"/usr/bin/openssl":' pkg.contrib/cca.sh
}

src_compile() {
	if has_version '=sys-libs/gdbm-1.8.3*' ; then
	     myconf="--enable-rule=SSL_SDBM"
	fi

	SSL_BASE=SYSTEM \
	./configure \
		--with-apxs=${APXS1} ${myconf} || die "bad ./configure"
	make || die "compile problem"
}

src_install() {
	apache1_src_install

	insinto ${APACHE1_VHOSTDIR}
	doins ${FILESDIR}/${VHOSTFILE}.conf

	exeinto /usr/lib/ssl/mod_ssl
	doexe pkg.contrib/*.sh ${FILESDIR}/gentestcrt.sh

	dodir /usr/share/doc/${PF}/html
	cp -a pkg.ssldoc/* ${D}/usr/share/doc/${PF}/html
}

pkg_postinst() {
	install -d -o root -g root -m0755 ${ROOT}${APACHE1_CONFDIR}/ssl

	apache1_pkg_postinst

	cd ${ROOT}${APACHE1_CONFDIR}/ssl
	einfo "Generating self-signed test certificate in ${APACHE1_CONFDIR}/ssl..."
	einfo "(Ignore any message from the yes command below)"
	yes "" | ${ROOT}/usr/lib/ssl/mod_ssl/gentestcrt.sh >/dev/null 2>&1
	einfo
}
