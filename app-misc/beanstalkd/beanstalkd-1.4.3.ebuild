# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beanstalkd/beanstalkd-1.4.3.ebuild,v 1.1 2010/01/04 19:03:07 patrick Exp $

inherit eutils

DESCRIPTION="A fast, distributed, in-memory workqueue service"
HOMEPAGE="http://xph.us/software/beanstalkd/"
SRC_URI="http://xph.us/dist/beanstalkd/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

RDEPEND=">=dev-libs/libevent-1.4.7"
DEPEND="${RDEPEND}
	test? ( net-analyzer/netcat )"

IUSE="test"

pkg_preinst() {
	enewuser beanstalk -1 -1 /dev/null daemon
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	DATADIR=/var/lib/${PN}
	dodir "${DATADIR}" || die "Install failed"
	fowners beanstalk:daemon "${DATADIR}"

	dodoc README TODO doc/*.txt

	newconfd "${FILESDIR}/conf-1.4.2" beanstalkd
	newinitd "${FILESDIR}/init-1.4.2" beanstalkd
}
