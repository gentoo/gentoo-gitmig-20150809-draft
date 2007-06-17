# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/simscan/simscan-1.3.1.ebuild,v 1.1 2007/06/17 11:46:24 hollow Exp $

inherit autotools toolchain-funcs eutils fixheadtails flag-o-matic

DESCRIPTION="Simscan, a qmail scanner"
HOMEPAGE="http://inter7.com/?page=simscan"
SRC_URI="http://inter7.com/simscan/${P}.tar.gz"
LICENSE="GPL-1"

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

	use clamav && usermod -G simscan,nofiles clamav
}

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"

	epatch ${FILESDIR}/${P}-destdir.patch
	epatch ${FILESDIR}/${P}-printf.patch

	sed -i "s:daily.cvd:main.cvd:g" configure
	sed -i "s:daily.cvd:main.cvd:g" configure.in
	sed -i "s:daily.cvd:main.cvd:g" simscanmk.c

	eautoreconf
}

src_compile() {
	econf \
		--enable-user=simscan \
		--enable-qmaildir=/var/qmail \
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
	dodoc AUTHORS README TODO

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
	einfo "Updating simscan configuration files ..."
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
