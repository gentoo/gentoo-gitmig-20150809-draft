# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dkim-milter/dkim-milter-2.3.0-r1.ebuild,v 1.1 2007/10/09 20:25:31 mrness Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A milter-based application to provide DomainKeys Identified Mail (DKIM) service"
HOMEPAGE="http://sourceforge.net/projects/dkim-milter/"
SRC_URI="mirror://sourceforge/dkim-milter/${P}.tar.gz"

LICENSE="Sendmail-Open-Source"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="approx-regex"

RDEPEND="dev-libs/openssl
	>=sys-libs/db-3.2
	|| ( mail-filter/libmilter mail-mta/sendmail )
	approx-regex? ( dev-libs/tre )"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup milter
	enewuser milter -1 -1 -1 milter
}

src_unpack() {
	unpack ${A}

	cd "${S}" || die "source dir not found"
	cp site.config.m4.dist devtools/Site/site.config.m4 || \
		die "failed to generate site.config.m4"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	sed -i -e "s:@@CFLAGS@@:${CFLAGS}:" \
		devtools/Site/site.config.m4
}

src_compile() {
	local MY_LIBS
	use approx-regex && MY_LIBS="-ltre"
	emake -j1 CC="$(tc-getCC)" LIBADD="${MY_LIBS}" || die "emake failed"
}

src_test() {
	emake -j1 OPTIONS=check \
		|| die "./Build check failed"
}

src_install() {
	# prepare directory for private keys.
	dodir /etc/mail/dkim-filter
	fowners milter:milter /etc/mail/dkim-filter
	fperms 700 /etc/mail/dkim-filter

	# prepare directory for PID file
	dodir /var/run/dkim-filter
	fowners milter:milter /var/run/dkim-filter

	dodir /usr/bin /usr/share/man/man{3,5,8}
	emake -j1 DESTDIR="${D}" \
		MANROOT=/usr/share/man/man MANOWN=root MANGRP=root \
		install || die "make install failed"

	dobin "$FILESDIR"/dkim-gettxt.sh || die "dobin failed"

	newinitd "${FILESDIR}/dkim-filter.init" dkim-filter \
		|| die "newinitd failed"
	newconfd "${FILESDIR}/dkim-filter.conf" dkim-filter \
		|| die "newconfd failed"
}

pkg_postinst() {
	pkg_setup # create milter user

	einfo "You might want to run dkim-gettxt.sh to generate"
	einfo "the necessary keys to use with dkim-filter if you have"
	einfo "not done so already."
}
