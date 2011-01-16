# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lessfs/lessfs-1.3.1.ebuild,v 1.1 2011/01/16 13:44:23 hwoarang Exp $

EAPI="2"

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A high performance inline data deduplicating filesystem"
HOMEPAGE="http://www.lessfs.com"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${P/_beta*/-beta}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lzo crypt debug"

DEPEND=">=dev-db/tokyocabinet-1.4.42
		app-crypt/mhash
		>=sys-fs/fuse-2.8.0
		crypt? ( dev-libs/openssl )
		lzo? ( dev-libs/lzo )"

RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		$(use_enable debug) $(use_enable debug lckdebug) \
		$(use_with crypt crypto) $(use_with lzo)
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog FAQ README.* || die "dodpc failed"
	insinto /etc
	newins examples/lessfs.cfg-master ${PN}.cfg || die "newins failed"
	dodoc examples/lessfs.* etc/lessfs.* || die "dodoc failed"
	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die "newconfd failed"
	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die "newinitd failed"

}

pkg_postinst() {
	elog
	elog "Default configuration file: /etc/${PN}.cfg"
	elog "If your host is a client consult the following configuration"
	elog "file: /usr/share/doc/${PF}/${PN}.cfg-slave.bz2"
	elog
	elog "${PN} new installs an init script. Adjust /etc/conf.d/${PN}"
	elog "to fit your needs"
}
