# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cyrus-imap-admin/cyrus-imap-admin-2.4.8.ebuild,v 1.1 2011/05/11 13:57:01 eras Exp $

EAPI=2

inherit perl-app db-use

MY_PV=${PV/_/}

PIC_PATCH_VER="2.2"
DESCRIPTION="Utilities and Perl modules to administer a Cyrus IMAP server."
HOMEPAGE="http://www.cyrusimap.org/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl kerberos"

RDEPEND=">=sys-libs/db-3.2
	>=dev-lang/perl-5.6.1
	>=dev-libs/cyrus-sasl-2.1.13
	dev-perl/Term-ReadLine-Perl
	dev-perl/TermReadKey
	ssl? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( virtual/krb5 )"

DEPEND="$RDEPEND"

S="${WORKDIR}/cyrus-imapd-${MY_PV}"

src_configure() {
	econf \
		--disable-server \
		--enable-murder \
		--enable-netscapehack \
		--with-cyrus-group=mail \
		--with-com_err=yes \
		--with-perl=/usr/bin/perl \
		--without-krb \
		--without-krbdes \
		--with-bdb \
		--with-bdb-incdir=$(db_includedir) \
		$(use_enable kerberos gssapi) \
		$(use_with ssl openssl)
}

src_compile() {
	emake -C "${S}/lib" all || die "compile problem"
	emake -C "${S}/perl" all || die "compile problem"
}

src_install () {
	emake -C "${S}/perl" DESTDIR="${D}" INSTALLDIRS=vendor install || die "install problem"
	fixlocalpod		# bug #98122
}
