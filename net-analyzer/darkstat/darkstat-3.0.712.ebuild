# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/darkstat/darkstat-3.0.712.ebuild,v 1.1 2009/01/05 20:07:19 pva Exp $

inherit eutils

DESCRIPTION="darkstat is a network traffic analyzer"
HOMEPAGE="http://dmr.ath.cx/net/darkstat/"
SRC_URI="http://dmr.ath.cx/net/darkstat/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-libs/libpcap"

DARKSTAT_CHROOT_DIR=${DARKSTAT_CHROOT_DIR:-/var/lib/darkstat}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-dlt_raw.patch"
}

src_compile() {
	econf --with-privdrop-user=darkstat \
			--with-chroot-dir="${DARKSTAT_CHROOT_DIR}"
	emake || die "compilation failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed."

	dodoc AUTHORS README THANKS NEWS || die

	newinitd "${FILESDIR}"/darkstat-init.new darkstat || die
	newconfd "${FILESDIR}"/darkstat-confd.new darkstat || die

	sed -i -e "s:__CHROOT__:${DARKSTAT_CHROOT_DIR}:g" "${D}"/etc/conf.d/darkstat
	sed -i -e "s:__CHROOT__:${DARKSTAT_CHROOT_DIR}:g" "${D}"/etc/init.d/darkstat

	keepdir "${DARKSTAT_CHROOT_DIR}"
	chown darkstat:0 "${D}${DARKSTAT_CHROOT_DIR}"
}

pkg_preinst() {
	enewuser darkstat
}

pkg_postinst() {
	# Workaround bug #141619
	DARKSTAT_CHROOT_DIR=`sed -n 's/^#CHROOT=\(.*\)/\1/p' "${ROOT}"etc/conf.d/darkstat`
	chown darkstat:0 "${ROOT}${DARKSTAT_CHROOT_DIR}"

	elog "WARNING: the darkstat init script has changed"
	elog "To start different darkstat instances which will listen on a different"
	elog "interfaces create in /etc/init.d directory the 'darkstat.if' symlink to"
	elog "darkstat script where 'if' is the name of the interface."
	elog "Also in /etc/conf.d directory copy darkstat to darkstat.if"
	elog "and edit it to change default values."
	elog
	elog "darkstat's default chroot directory is: \"${ROOT}${DARKSTAT_CHROOT_DIR}\""
}
