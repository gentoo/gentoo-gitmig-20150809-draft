# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: #

EAPI="3"

inherit eutils

DESCRIPTION="A fast, distributed, in-memory workqueue service"
HOMEPAGE="http://xph.us/software/beanstalkd/"
SRC_URI="mirror://github/kr/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~mips ~sparc-fbsd ~x64-macos ~x86 ~x86-fbsd ~x86-macos"

RDEPEND=""
DEPEND="test? ( dev-lang/python )"

IUSE="test"

pkg_setup() {
	enewuser beanstalk -1 -1 /var/lib/beanstalkd daemon
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "compile failed"
}

src_install() {
	dobin beanstalkd || die

	DATADIR=/var/lib/${PN}
	dodir ${DATADIR} || die
	fowners beanstalk:daemon ${DATADIR}

	doman doc/"${PN}".1

	dodoc README NEWS.md doc/*.txt || die

	newconfd "${FILESDIR}/conf-1.4.2" beanstalkd
	newinitd "${FILESDIR}/init-1.4.6" beanstalkd
}