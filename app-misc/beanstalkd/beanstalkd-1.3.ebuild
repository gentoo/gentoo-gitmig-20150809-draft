# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beanstalkd/beanstalkd-1.3.ebuild,v 1.7 2010/11/01 17:46:59 halcy0n Exp $

inherit eutils

RESTRICT="test"

DESCRIPTION="A fast, distributed, in-memory workqueue service"
HOMEPAGE="http://xph.us/software/beanstalkd/"
SRC_URI="http://xph.us/dist/beanstalkd/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~mips x86 ~sparc-fbsd ~x86-fbsd"

RDEPEND=">=dev-libs/libevent-1.4.7"
DEPEND="${RDEPEND}"

IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodoc README TODO doc/*.txt

	newconfd "${FILESDIR}/conf" beanstalkd
	newinitd "${FILESDIR}/init" beanstalkd
}

pkg_postinst() {
	enewuser beanstalk -1 -1 /dev/null daemon
}
