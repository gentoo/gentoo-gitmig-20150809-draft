# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tripwire/tripwire-2.3.1.2-r2.ebuild,v 1.7 2005/08/22 18:08:01 taviso Exp $

inherit eutils flag-o-matic

TW_VER="2.3.1-2"
DESCRIPTION="Open Source File Integrity Checker and IDS"
HOMEPAGE="http://www.tripwire.org/"
SRC_URI="mirror://sourceforge/tripwire/tripwire-${TW_VER}.tar.gz
	mirror://gentoo/tripwire-2.3.1-2-pherman-portability-0.9.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="ssl"

DEPEND="virtual/libc
		sys-devel/automake
		sys-devel/autoconf
		dev-util/patchutils
		ssl? ( dev-libs/openssl )"
RDEPEND="virtual/libc
		virtual/cron
		virtual/mta
		ssl? ( dev-libs/openssl )"

S=${WORKDIR}/tripwire-${TW_VER}

src_unpack() {
	# unpack tripwire source tarball
	unpack tripwire-${TW_VER}.tar.gz; cd ${S}

	# Paul Herman has been maintaining some updates to tripwire
	# including autoconf support and portability fixes.
	# http://www.frenchfries.net/paul/tripwire/
	epatch ${DISTDIR}/tripwire-2.3.1-2-pherman-portability-0.9.diff.bz2
	epatch ${FILESDIR}/tripwire-2.3.0-50-rfc822.patch.bz2
}

src_compile() {
	# tripwire can be sensitive to compiler optimisation.
	# see #32613, #45823, and others.
	# 	-taviso@gentoo.org
	strip-flags
	append-flags -DCONFIG_DIR='"\"/etc/tripwire\""' -fno-strict-aliasing

	einfo "Preparing build..."
		rm -f ${S}/configure
		ebegin "	Running aclocal"
			aclocal &> /dev/null || true
		eend
		ebegin "	Running autoheader"
			autoheader &> /dev/null || true
		eend
		ebegin "	Running automake"
			automake --add-missing &> /dev/null || true
		eend
		ebegin "	Running autoreconf"
			autoreconf &> /dev/null || true
		eend
		ebegin "	Preparing Directory"
			mkdir ${S}/lib ${S}/bin || die
		eend
	einfo "Done."
	econf `use_enable ssl openssl` || die
	emake || die
}

src_install() {
	dosbin ${S}/bin/{siggen,tripwire,twadmin,twprint}
	doman ${S}/man/man{4/*.4,5/*.5,8/*.8}
	dodir /etc/tripwire /var/lib/tripwire{,/report}
	keepdir /var/lib/tripwire{,/report}

	exeinto /etc/cron.daily
	doexe ${FILESDIR}/tripwire.cron

	dodoc README Release_Notes ChangeLog policy/policyguide.txt TRADEMARK \
		${FILESDIR}/tripwire.gif ${FILESDIR}/tripwire.txt

	zcat ${FILESDIR}/twpol.txt > ${T}/twpol.txt || ewarn "twcfg.txt zcat error"
	insinto /etc/tripwire
	doins ${T}/twpol.txt ${FILESDIR}/twcfg.txt

	exeinto /etc/tripwire
	doexe ${FILESDIR}/twinstall.sh

	fperms 755 /etc/tripwire/twinstall.sh /etc/cron.daily/tripwire.cron
}

pkg_postinst() {
	einfo "After installing this package, you should run \"/etc/tripwire/twinstall.sh\""
	einfo "to generate cryptographic keys, and \"tripwire --init\" to initialize the"
	einfo "database Tripwire uses."
	einfo
	einfo "A quickstart guide is included with the documentation."
	einfo
}
