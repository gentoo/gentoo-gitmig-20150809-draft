# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dkim-milter/dkim-milter-2.2.1.ebuild,v 1.1 2007/10/06 13:40:10 dragonheart Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A milter-based application to provide DomainKeys Identified Mail (DKIM) service"
HOMEPAGE="http://sourceforge.net/projects/dkim-milter/"
SRC_URI="mirror://sourceforge/dkim-milter/${P}.tar.gz"
LICENSE="Sendmail-Open-Source"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/openssl
	>=sys-libs/db-3.2
	mail-filter/libmilter
	dev-libs/tre"

pkg_setup() {
	enewgroup milter
	enewuser milter -1 -1 -1 milter
}

src_unpack() {
	unpack "${A}"

	confCCOPTS="${CFLAGS}"
	confENVDEF=""
	sed -e "s:@@confCCOPTS@@:${confCCOPTS}:" \
		-e "s/@@confENVDEF@@/${confENVDEF}/" \
		"${FILESDIR}"/site.config.m4 > "${S}"/devtools/Site/site.config.m4
}

src_compile() {
	emake  CC="$(tc-getCC)" || die "emake failed"
}


src_test() {
	./Build check || die
}

src_install() {
	OBJDIR="obj.`uname -s`.`uname -r`.`arch`"

	# prepare directory for private keys.
	dodir /etc/mail/dkim-filter
	keepdir /etc/mail/dkim-filter
	fowners milter:milter /etc/mail/dkim-filter
	fperms 700 /etc/mail/dkim-filter

	# prepare directory for PID file
	dodir /var/run/dkim-filter
	fowners milter:milter /var/run/dkim-filter

	dodir /usr/bin /usr/share/man/man8 /usr/share/man/man5

	emake DESTDIR="${D}" \
		install -C "${OBJDIR}"/dkim-filter \
			|| die "make install failed"
	dobin "$FILESDIR"/dkim-gettxt.sh || die "dobin failed"

	newinitd "${FILESDIR}/dkim-filter.init" dkim-filter \
		|| die "newinitd failed"
	newconfd "${FILESDIR}/dkim-filter.conf" dkim-filter \
		|| die "newconfd failed"

	einfo "You might want to run dkim-gettxt.sh to generate"
	einfo "the necessary keys to use with dkim-filter if you have"
	einfo "not done so already."
}

