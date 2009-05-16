# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/policyd/policyd-1.80.ebuild,v 1.4 2009/05/16 00:18:30 halcy0n Exp $

inherit eutils

DESCRIPTION="Policy daemon for postfix and other MTAs"
HOMEPAGE="http://policyd.sf.net/"

# This is not available through SF mirrors
SRC_URI="http://policyd.sourceforge.net/${PN}-v${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-db/mysql
		dev-libs/openssl"
RDEPEND="${DEPEND}"

MY_P=${PN}-v${PV}
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-makefile.patch"

	ebegin "Applying config patches"
	sed -i -e s:UID=0:UID=65534:g \
	    -e s:GID=0:GID=65534:g \
	    -e s:DAEMON=0:DAEMON=1:g \
	    -e s:DEBUG=3:DEBUG=0:g \
	    -e s:DATABASE_KEEPALIVE=0:DATABASE_KEEPALIVE=1:g \
	    policyd.conf || die "sed failed"
	eend
}

src_compile() {
	emake build || die "emake build failed"
}

src_install() {
	insopts -o root -g nobody -m 0750
	mv cleanup policyd_cleanup
	mv stats policyd_stats

	dosbin policyd policyd_cleanup policyd_stats

	insopts -o root -g nobody -m 0640
	insinto /etc
	doins policyd.conf

	insopts -o root -g nobody -m 0700
	exeinto /etc/cron.hourly
	newexe "${FILESDIR}/${PN}-cleanup.cron" ${PN}-cleanup.cron

	dodoc Changelog.txt DATABASE.mysql License.txt README.txt doc/support.txt

	newinitd "${FILESDIR}/${PN}.rc" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}

pkg_postinst() {
	einfo "You will need to create the database using the script DATABASE.mysql"
	einfo "in /usr/share/doc/${PF}/"
	einfo "Read the mysql section of the README.txt for details."
	einfo
	einfo "To use policyd with postfix, update your /etc/postfix/main.cf file by adding"
	einfo "  check_policy_service inet:127.0.0.1:10031"
	einfo "to your smtpd_recipient_restrictions line, or similar."
	einfo
	einfo "Also remember to start the daemon at boot:"
	einfo "  rc-update add policyd default"
	einfo
	einfo "Read the documentation for more info."
}
