# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.4.ebuild,v 1.3 2003/12/27 12:26:38 taviso Exp $

inherit eutils

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2
	idea? ( ftp://ftp.gnupg.dk/pub/contrib-dk/idea.c.gz )"
SLOT="0"
LICENSE="GPL-2"

# IDEA license is rather restrictive if you're unlucky enough to
# live in a country where its patented, however it is FAIB for
# non-commercial use.
use idea && LICENCE="${LICENCE} | IDEA"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64 ~ia64"
IUSE="X ldap nls static caps idea"

RDEPEND="!static? ( ldap? ( net-nds/openldap )
		caps? ( sys-libs/libcap )
		app-arch/bzip2
		sys-libs/zlib )
	X? ( x11-misc/xloadimage )
	nls? ( sys-devel/gettext )
	virtual/glibc
	dev-lang/perl
	virtual/mta"

# XXX: libpcap earlier than 1.10-r3 did not provide libcap.a
#	DEPEND="caps? ( static? ( >=sys-libs/libcap-1.10-r3 )
#				!static? ( sys-libs/libcap ) )
DEPEND="caps? ( sys-libs/libcap )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	!static? ( sys-libs/zlib )
	app-arch/bzip2
	virtual/glibc
	dev-lang/perl"

src_unpack() {
	unpack ${A}

	# Please read http://www.gnupg.org/why-not-idea.html
	if use idea; then
		mv ${WORKDIR}/idea.c ${S}/cipher/idea.c || ewarn "failed to insert IDEA module"
	fi
}

src_compile() {
	# support for external HKP keyservers requested in #16457.
	local myconf="--enable-external-hkp --enable-static-rnd=linux --libexecdir=/usr/lib --enable-sha512"

	if ! use nls; then
		myconf="${myconf} --disable-nls"
	fi

	if use ldap; then
		myconf="${myconf} --enable-ldap"
	else
		myconf="${myconf} --disable-ldap"
	fi

	if use X; then
		myconf="${myconf} --enable-photo-viewers"
	else
		myconf="${myconf} --disable-photo-viewers"
	fi

	# `USE=static` support was requested in #29299
	if use static; then
		myconf="${myconf} --with-included-zlib"
		export LDFLAGS="${LDFLAGS} -static"
	else
		myconf="${myconf} --without-included-zlib"
	fi

	if use caps; then
		myconf="${myconf} --with-capabilities"
	fi

	# Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	if ! use sparc; then
		myconf="${myconf} --enable-m-guard"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall libexecdir="${D}/usr/lib/gnupg"

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS PROJECTS \
	README THANKS TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

	use idea && dodoc ${S}/cipher/idea.c

	docinto sgml
	dodoc doc/*.sgml

	dohtml doc/faq.html

	if ! use caps; then
		chmod u+s "${D}/usr/bin/gpg"
	fi
}

pkg_postinst() {
	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
	echo
	if use idea; then
		einfo "you have compiled ${PN} with support for the IDEA algorithm, this code"
		einfo "is distributed under the GPL in countries where it is permitted to do so"
		einfo "by law."
		einfo
		einfo "Please read http://www.gnupg.org/why-not-idea.html for more information."
		einfo
		einfo "If you are in a country where the IDEA algorithm is patented, you are permitted"
		einfo "to use it at no cost for 'non revenue generating data transfer between private"
		einfo "individuals'."
		einfo
		einfo "Countries where the patent applies are listed here"
		einfo "http://www.mediacrypt.com/engl/Content/patent_info.htm"
		einfo
		einfo "Further information and other licenses are availble from http://www.mediacrypt.com/"
	fi
}
