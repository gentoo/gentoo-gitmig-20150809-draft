# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/csync2/csync2-1.34.ebuild,v 1.2 2007/09/20 20:59:18 xmerlin Exp $

DESCRIPTION="Cluster synchronization tool."
SRC_URI="http://oss.linbit.com/csync2/${P}.tar.gz"
HOMEPAGE="http://oss.linbit.com/csync2/"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=net-libs/librsync-0.9.5
	=dev-db/sqlite-2.8*
	>=net-libs/gnutls-1.0.0
	"

RDEPEND="${DEPEND}"

SLOT="0"

src_compile() {
	econf \
		--localstatedir=/var \
		--sysconfdir=/etc/csync2 \
		|| die "configure problem"

	emake || die "compile problem"
}


src_install() {
	emake DESTDIR="${D}" \
		localstatedir=/var \
		sysconfdir=/etc/csync2 \
		install || die "install problem"

	insinto /etc/xinetd.d
	newins ${FILESDIR}/${PN}.xinetd ${PN} || die

	dodir /var/lib/csync2/ || die
	keepdir /var/lib/csync2/

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO csync2_locheck.sh
}


pkg_postinst() {
	echo
	einfo "After you setup your conf file, edit the xinetd"
	einfo "entry in /etc/xinetd.d/${PN} to enable, then"
	einfo "start xinetd: /etc/init.d/xinetd start"
	echo
	einfo "To add ${PN} to your services file just run"
	einfo "this command after you install:"
	echo
	einfo "emerge  --config =${PF}"
	echo
	einfo "Now you can find csync2.cfg under /etc/${PN}"
	einfo "Please move you old config to the right location"
	echo
}


pkg_config() {
	einfo "Updating ${ROOT}/etc/services"
	{ grep -v ^${PN} "${ROOT}"/etc/services;
	echo "csync2  30865/tcp"
	} > "${ROOT}"/etc/services.new
	mv -f "${ROOT}"/etc/services.new "${ROOT}"/etc/services

	if [ ! -f "${ROOT}"/etc/${PN}/csync2_ssl_key.pem ]; then
		einfo "Creating default certificate in ${ROOT}/etc/${PN}"

		openssl genrsa -out "${ROOT}"/etc/${PN}/csync2_ssl_key.pem 1024 &> /dev/null

		yes '' | \
		openssl req -new \
			-key "${ROOT}"/etc/${PN}/csync2_ssl_key.pem \
			-out "${ROOT}"/etc/${PN}/csync2_ssl_cert.csr \
			&> "${ROOT}"/dev/null

		openssl x509 -req -days 600 \
			-in "${ROOT}"/etc/${PN}/csync2_ssl_cert.csr \
			-signkey "${ROOT}"/etc/${PN}/csync2_ssl_key.pem \
			-out "${ROOT}"/etc/${PN}/csync2_ssl_cert.pem \
			&> "${ROOT}"/dev/null

		rm "${ROOT}"/etc/${PN}/csync2_ssl_cert.csr
		chmod 400 "${ROOT}"/etc/${PN}/csync2_ssl_key.pem "${ROOT}"/etc/${PN}/csync2_ssl_cert.pem
	fi
}
