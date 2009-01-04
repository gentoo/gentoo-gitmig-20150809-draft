# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cyrus-imap-admin/cyrus-imap-admin-2.3.13.ebuild,v 1.4 2009/01/04 15:41:05 maekke Exp $

inherit autotools perl-app eutils

MY_PV=${PV/_/}

PIC_PATCH_VER="2.2"
DESCRIPTION="Utilities and Perl modules to administer a Cyrus IMAP server."
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ~ppc64 sparc x86"
IUSE="ssl kerberos kolab"

RDEPEND=">=sys-libs/db-3.2
	>=dev-lang/perl-5.6.1
	>=dev-libs/cyrus-sasl-2.1.13
	dev-perl/Term-ReadLine-Perl
	dev-perl/TermReadKey
	ssl? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( virtual/krb5 )"

DEPEND="$RDEPEND
	sys-devel/libtool
	>=sys-devel/autoconf-2.58
	sys-devel/automake
	>=sys-apps/sed-4"

S="${WORKDIR}/cyrus-imapd-${MY_PV}"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Versioned symbols.
	epatch "${FILESDIR}/${PN}-${PIC_PATCH_VER}-fPIC.patch"

	# Recreate configure.
	WANT_AUTOCONF="2.5"
	eautoreconf

	# When linking with rpm, you need to link with more libraries.
	sed -e "s:lrpm:lrpm -lrpmio -lrpmdb:" -i configure || die "sed failed"

	# Add kolab support.
	if use kolab ; then
		epatch "${FILESDIR}/${P}-kolab-annotations.patch" || die "epatch failed"
	fi
}

src_compile() {

	local myconf
	myconf="${myconf} `use_with ssl openssl`"
	myconf="${myconf} `use_with kerberos gssapi`"

	econf \
		--disable-server \
		--enable-murder \
		--enable-listext \
		--enable-netscapehack \
		--with-cyrus-group=mail \
		--with-com_err=yes \
		--with-auth=unix  \
		--with-perl=/usr/bin/perl \
		--enable-cyradm \
		${myconf} || die "econf failed"

	emake -C "${S}/lib" all || die "compile problem"
	emake -C "${S}/perl" all || die "compile problem"
}

src_install () {
	make -C "${S}/perl" DESTDIR="${D}" install || die "install problem"
	fixlocalpod		# bug #98122
}
