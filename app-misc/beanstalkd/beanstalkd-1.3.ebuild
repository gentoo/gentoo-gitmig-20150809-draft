# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beanstalkd/beanstalkd-1.3.ebuild,v 1.1 2009/06/23 11:53:24 patrick Exp $

inherit eutils

DESCRIPTION="A fast, distributed, in-memory workqueue service"
HOMEPAGE="http://xph.us/software/beanstalkd/"
SRC_URI="http://xph.us/dist/beanstalkd/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

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
