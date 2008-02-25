# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/simscan/simscan-1.4.0.ebuild,v 1.2 2008/02/25 17:21:50 jer Exp $

inherit autotools toolchain-funcs eutils fixheadtails flag-o-matic

DESCRIPTION="Simscan, a qmail scanner"
HOMEPAGE="http://inter7.com/?page=simscan"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="attachment clamav dropmsg passthru per-domain quarantine regex received spamassassin"

RESTRICT="test"

DEPEND="attachment? ( net-mail/ripmime )
		clamav? ( app-antivirus/clamav )
		spamassassin? ( mail-filter/spamassassin )
		regex? ( dev-libs/libpcre )"

RDEPEND="${DEPEND}
		virtual/qmail"

pkg_setup() {
	test -z "${SIMSCAN_HITS}" && SIMSCAN_HITS=10

	enewgroup simscan
	enewuser simscan -1 -1 /dev/null simscan

	use clamav && usermod -a -G simscan,nofiles clamav
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.3.1-destdir.patch \
		"${FILESDIR}"/${PN}-1.3.1-printf.patch

	sed -i \
		-e "s:daily.cvd:main.cvd:g" \
		configure.in \
		simscanmk.c \
		|| die "sed failed"

	eautoreconf
}

src_compile() {
	econf \
		--enable-qmaildir=/var/qmail \
		--enable-qmail-queue=/var/qmail/bin/qmail-queue \
		$(use_enable attachment attach) \
		$(use_enable clamav) \
		$(use_enable clamav clamdscan /usr/bin/clamdscan) \
		$(use_enable clamav clamavdb-path /var/lib/clamav) \
		$(use_enable dropmsg) \
		$(use_enable spamassassin spam) \
		$(use_enable spamassassin spamc /usr/bin/spamc) \
		$(use_enable spamassassin spam-hits ${SIMSCAN_HITS}) \
		$(use_enable passthru spam-passthru) \
		$(use_enable quarantine quarantinedir /var/qmail/quarantine) \
		$(use_enable regex) \
		$(use_enable received) \
		$(use_enable per-domain) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO

	keepdir /var/qmail/control
	keepdir /var/qmail/simscan

	if use clamav; then
		echo -n ":clam=yes," > "${D}"/var/qmail/control/simcontrol
	else
		echo -n ":clam=no," > "${D}"/var/qmail/control/simcontrol
	fi

	if use spamassassin; then
		echo "spam=yes,spam_hits=${SIMSCAN_HITS}" >> "${D}"/var/qmail/control/simcontrol
	else
		echo "spam=no" >> "${D}"/var/qmail/control/simcontrol
	fi
}

pkg_postinst() {
	ewarn "Updating simscan configuration files ..."
	/var/qmail/bin/simscanmk

	ewarn
	ewarn "You have to do that every time you update clamav or spamassassin"
	ewarn

	einfo
	einfo "In order use simscan update the QMAILQUEUE environment variable"
	einfo "and point it to /var/qmail/bin/simscan"
	einfo
	einfo "Read the documentation and customize /var/qmail/control/simcontrol"
	einfo
}
