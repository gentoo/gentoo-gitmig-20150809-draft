# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/freeipmi/freeipmi-0.8.8.ebuild,v 1.1 2010/08/08 03:46:39 flameeyes Exp $

EAPI=2

DESCRIPTION="Provides Remote-Console and System Management Software as per IPMI v1.5/2.0"
HOMEPAGE="http://www.gnu.org/software/freeipmi/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	http://ftp.gluster.com/pub/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug syslog"

RDEPEND="dev-libs/libgcrypt"
DEPEND="${RDEPEND}
		virtual/os-headers"

src_prepare() {
	# Fix build mistake, only causes warnings but at least stop it.
	sed -i -e '/-module/d' "${S}"/libfreeipmi/src/Makefile.am || die
}

src_configure() {
	econf \
		--disable-init-scripts \
		$(use_enable debug) \
		--enable-logrotate-config \
		$(use_enable syslog) \
		--localstatedir=/var \
		--disable-static \
		|| die "econf failed"
}

# There are no tests
src_test() { :; }

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install || die "emake install failed"
	find "${D}" -name '*.la' -delete

	dodoc AUTHORS ChangeLog* DISCLAIMER* NEWS README* TODO doc/*.txt || die

	keepdir \
		/var/cache/ipmimonitoringsdrcache \
		/var/lib/freeipmi \
		/var/log/{freeipmi,ipmiconsole}

	newinitd "${FILESDIR}/ipmidetectd.initd" ipmidetectd
	newinitd "${FILESDIR}/bmc-watchdog.initd" bmc-watchdog
	newconfd "${FILESDIR}/bmc-watchdog.confd" bmc-watchdog
}
