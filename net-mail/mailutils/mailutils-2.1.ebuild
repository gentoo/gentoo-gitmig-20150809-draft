# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-2.1.ebuild,v 1.2 2010/01/21 20:52:16 jer Exp $

EAPI="2"

inherit eutils flag-o-matic python

DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="http://ftp.gnu.org/gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="gdbm guile mysql nls pam postgres python test"
PROVIDE="virtual/mailx"

RDEPEND="!virtual/mailx
	!mail-client/nmh
	!mail-filter/libsieve
	guile? ( dev-scheme/guile )
	gdbm? ( sys-libs/gdbm )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base )
	nls? ( sys-devel/gettext )
	virtual/mta"

DEPEND="${RDEPEND}
	test? ( dev-util/dejagnu )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-python.patch
}

src_configure() {
	# TODO: Fix this breakage, starting in examples/cpp/
	append-ldflags $(no-as-needed)

	local myconf="--localstatedir=/var --sharedstatedir=/var"
	myconf="${myconf} --enable-mh"

	# We need sendmail or compiling will fail
	myconf="${myconf} --enable-sendmail"

	econf ${myconf} \
		$(use_with gdbm) \
		$(use_with guile) \
		$(use_with mysql) \
		$(use_with postgres) \
		$(use_enable nls) \
		$(use_enable pam) \
		$(use_with python) \
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
