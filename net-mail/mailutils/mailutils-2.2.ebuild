# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-2.2.ebuild,v 1.5 2011/07/29 18:50:17 grobian Exp $

EAPI="3"

inherit eutils flag-o-matic libtool python

DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="http://ftp.gnu.org/gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

KEYWORDS="~alpha amd64 ~hppa ~ppc ~sparc x86 ~ppc-macos ~x64-macos ~x86-macos"
IUSE="bidi gdbm guile ldap mysql nls pam postgres python test tokyocabinet"

RDEPEND="!mail-client/nmh
	!mail-filter/libsieve
	!mail-client/mailx
	!mail-client/nail
	bidi? ( dev-libs/fribidi )
	guile? ( dev-scheme/guile )
	gdbm? ( sys-libs/gdbm )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	nls? ( sys-devel/gettext )
	postgres? ( dev-db/postgresql-base )
	tokyocabinet? ( dev-db/tokyocabinet )
	virtual/mta"

DEPEND="${RDEPEND}
	test? ( dev-util/dejagnu )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.1-python.patch
	elibtoolize  # for Darwin bundles
}

src_configure() {
	# TODO: Fix this breakage, starting in examples/cpp/
	append-ldflags $(no-as-needed)

	local myconf="--localstatedir=${EPREFIX}/var --sharedstatedir=${EPREFIX}/var"
	myconf="${myconf} --enable-mh"

	# We need sendmail or compiling will fail
	myconf="${myconf} --enable-sendmail"

	econf ${myconf} \
		$(use_with bidi fribidi) \
		$(use_with gdbm) \
		$(use_with guile) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_enable nls) \
		$(use_enable pam) \
		$(use_with postgres) \
		$(use_with python) \
		$(use_with tokyocabinet) \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	# mail.rc stolen from mailx, resolve bug #37302.
	insinto /etc
	doins "${FILESDIR}/mail.rc"
}

pkg_postinst() {
	python_mod_optimize "$(python_get_libdir)/site-packages/mailutils"
}
