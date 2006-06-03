# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/csync2/csync2-1.26.ebuild,v 1.3 2006/06/03 18:52:58 xmerlin Exp $

DESCRIPTION="Cluster synchronization tool."
SRC_URI="http://oss.linbit.com/csync2/${P}.tar.gz"
HOMEPAGE="http://oss.linbit.com/csync2/"

LICENSE="GPL-2"
KEYWORDS="x86"

IUSE=""

DEPEND=">=net-libs/librsync-0.9.5
	=dev-db/sqlite-2.8*
	"

RDEPEND="${DEPEND}"

SLOT="0"

src_compile() {
	econf --localstatedir=/var || die

	emake || die
}

src_install() {

	make DESTDIR=${D} localstatedir=${D}/var install || die "install problem"

	insinto /etc/xinetd.d
	newins ${FILESDIR}/${PN}.xinetd ${PN} || die

	dodir /var/lib/csync2/ || die
	keepdir /var/lib/csync2/

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
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
}

pkg_config() {
	einfo "Updating /etc/services"
	{ grep -v ^${PN} /etc/services;
	echo "csync2  30865/tcp"
	} > /etc/services.new
	mv -f /etc/services.new /etc/services

}
