# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ssl/mod_ssl-2.8.25-r10.ebuild,v 1.10 2007/01/14 20:38:43 chtekk Exp $

inherit apache-module multilib

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"

MY_P="${P}-1.3.34"

DESCRIPTION="An SSL module for the Apache 1.3 webserver."
HOMEPAGE="http://www.modssl.org/"
SRC_URI="http://www.modssl.org/source/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6k"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

APACHE1_MOD_FILE="${S}/pkg.sslmod/libssl.so"
APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="SSL"

VHOSTFILE="default-ssl"

DOCFILES="ANNOUNCE CHANGES CREDITS LICENSE NEWS README*"

need_apache1

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Proper path to OpenSSL
	sed -i -e 's:^\(openssl=\).*:\1"/usr/bin/openssl":' pkg.contrib/cca.sh
}

src_compile() {
	local myconf=""

	if has_version '=sys-libs/gdbm-1.8.3*' ; then
		myconf="${myconf} --enable-rule=SSL_SDBM"
	fi

	SSL_BASE=SYSTEM \
	./configure \
		--with-apxs=${APXS1} \
		${myconf} \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	apache1_src_install

	insinto "${APACHE1_VHOSTDIR}"
	doins "${FILESDIR}/${VHOSTFILE}.conf"

	exeinto /usr/$(get_libdir)/ssl/mod_ssl
	doexe pkg.contrib/*.sh "${FILESDIR}/gentestcrt.sh"

	dodir /usr/share/doc/${PF}/html
	cp -pPR pkg.ssldoc/* "${D}/usr/share/doc/${PF}/html"
}

pkg_postinst() {
	install -d -m0755 -o root -g root "${ROOT}${APACHE1_CONFDIR}/ssl"

	apache1_pkg_postinst

	cd "${ROOT}${APACHE1_CONFDIR}/ssl"
	einfo "Generating self-signed test certificate in ${APACHE1_CONFDIR}/ssl ..."
	einfo "(Ignore any message from the yes command below)"
	yes "" | "${ROOT}"/usr/lib/ssl/mod_ssl/gentestcrt.sh >/dev/null 2>&1
	einfo
}
