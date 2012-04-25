# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tripwire/tripwire-2.3.1.2-r2.ebuild,v 1.16 2012/04/25 16:07:04 jlec Exp $

inherit eutils flag-o-matic autotools

TW_VER="2.3.1-2"
DESCRIPTION="Open Source File Integrity Checker and IDS"
HOMEPAGE="http://www.tripwire.org/"
SRC_URI="mirror://sourceforge/tripwire/tripwire-${TW_VER}.tar.gz
	mirror://gentoo/tripwire-2.3.1-2-pherman-portability-0.9.diff.bz2
	mirror://gentoo/twpol.txt.gz
	mirror://gentoo/tripwire.gif"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE="ssl"

DEPEND="sys-devel/automake
	sys-devel/autoconf
	dev-util/patchutils
	ssl? ( dev-libs/openssl )"
RDEPEND="virtual/cron
	virtual/mta
	ssl? ( dev-libs/openssl )"

S="${WORKDIR}"/tripwire-${TW_VER}

src_unpack() {
	# unpack tripwire source tarball
	unpack tripwire-${TW_VER}.tar.gz
	unpack twpol.txt.gz
	cd "${S}"

	# Paul Herman has been maintaining some updates to tripwire
	# including autoconf support and portability fixes.
	# http://www.frenchfries.net/paul/tripwire/
	export EPATCH_OPTS="-F3 -l"
	epatch "${FILESDIR}"/tripwire-friend-classes.patch
	epatch "${DISTDIR}"/tripwire-2.3.1-2-pherman-portability-0.9.diff.bz2
	epatch "${FILESDIR}"/tripwire-2.3.0-50-rfc822.patch

	eautoreconf
}

src_compile() {
	# tripwire can be sensitive to compiler optimisation.
	# see #32613, #45823, and others.
	# 	-taviso@gentoo.org
	strip-flags
	append-flags -DCONFIG_DIR='"\"/etc/tripwire\""' -fno-strict-aliasing

		ebegin "	Preparing Directory"
			mkdir "${S}"/lib "${S}"/bin || die
		eend
	einfo "Done."
	chmod +x configure
	econf `use_enable ssl openssl`
	emake || die
}

src_install() {
	dosbin "${S}"/bin/{siggen,tripwire,twadmin,twprint}
	doman "${S}"/man/man{4/*.4,5/*.5,8/*.8}
	dodir /etc/tripwire /var/lib/tripwire{,/report}
	keepdir /var/lib/tripwire{,/report}

	exeinto /etc/cron.daily
	doexe "${FILESDIR}"/tripwire.cron

	dodoc README Release_Notes ChangeLog policy/policyguide.txt TRADEMARK \
		"${WORKDIR}"/tripwire.gif "${FILESDIR}"/tripwire.txt

	insinto /etc/tripwire
	doins "${WORKDIR}"/twpol.txt "${FILESDIR}"/twcfg.txt

	exeinto /etc/tripwire
	doexe "${FILESDIR}"/twinstall.sh

	fperms 755 /etc/tripwire/twinstall.sh /etc/cron.daily/tripwire.cron
}

pkg_postinst() {
	elog "After installing this package, you should run \"/etc/tripwire/twinstall.sh\""
	elog "to generate cryptographic keys, and \"tripwire --init\" to initialize the"
	elog "database Tripwire uses."
	elog
	elog "A quickstart guide is included with the documentation."
	elog
}
