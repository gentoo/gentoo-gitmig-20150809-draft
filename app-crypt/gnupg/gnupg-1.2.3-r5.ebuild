# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.3-r5.ebuild,v 1.5 2004/01/12 09:55:44 carpaski Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha arm hppa amd64 ia64 mips"
IUSE="X ldap nls static caps"

RDEPEND="!static? ( ldap? ( net-nds/openldap )
		caps? ( sys-libs/libcap )
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
	virtual/glibc
	dev-lang/perl"

# Certain sparc32 machines seem to have trouble building correctly with 
# -mcpu enabled.  While this is not a gnupg problem, it is a temporary
# fix until the gcc problem can be tracked down.

if [ "${ARCH}" == "sparc" ] && [ "${PROFILE_ARCH}" == "sparc" ]; then
	filter-flags "-mcpu=supersparc -mcpu=v8 -mcpu=v7"
fi

src_unpack() {
	unpack ${A}

	# disable the ability to create signatures using the 
	# ElGamal sign+encrypt (type 20) keys as well as to remove 
	# the option to create such keys.
	#
	# http://lists.gnupg.org/pipermail/gnupg-announce/2003q4/000277.html
	cd ${S}/g10; epatch ${FILESDIR}/${P}-disable-elgamal.diff

	# format string error in the hkp code could lead to arbritrary code
	# execution by malicious keyserver. This update from CVS.
	#
	# http://www.s-quadra.com/advisories/Adv-20031203.txt
	cd ${S}; epatch ${FILESDIR}/${P}-hkp-format-string.diff
}

src_compile() {
	# support for external HKP keyservers requested in #16457.
	# gpg faq entry 3.3 reccommends using --enable-static-rnd=linux 
	# whenever possible.
	local myconf="--enable-external-hkp --enable-static-rnd=linux --libexecdir=/usr/lib"

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

	newdoc ${FILESDIR}/${P}-disable-elgamal.diff README.elgamal

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
}
