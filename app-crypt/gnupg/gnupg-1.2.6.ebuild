# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.6.ebuild,v 1.28 2006/02/17 01:08:01 vanquirius Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/gnupg/${P}.tar.bz2
	idea? ( ftp://ftp.gnupg.dk/pub/contrib-dk/idea.c.gz )"

LICENSE="GPL-2 idea? ( IDEA )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE="X ldap nls static idea selinux"

RDEPEND="!static? ( ldap? ( net-nds/openldap )
			app-arch/bzip2
			sys-libs/zlib )
	X? ( || ( media-gfx/xloadimage media-gfx/xli ) )
	nls? ( virtual/libintl )
	dev-lang/perl
	virtual/libc
	virtual/mta
	selinux? ( sec-policy/selinux-gnupg )"

DEPEND="ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	!static? ( sys-libs/zlib )
	app-arch/bzip2
	dev-lang/perl
	virtual/libc
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	# Please read http://www.gnupg.org/why-not-idea.html
	if use idea; then
		mv ${WORKDIR}/idea.c ${S}/cipher/idea.c || \
			ewarn "failed to insert IDEA module"
	fi

	cd ${S}
	epatch ${FILESDIR}/gnupg-1.2.6-ppc64.patch
	sed -i -e 's:PIC:__PIC__:' mpi/i386/mpih-{add,sub}1.S intl/relocatable.c
	sed -i -e 's:if PIC:ifdef __PIC__:' mpi/sparc32v8/mpih-mul{1,2}.S
}

src_compile() {
	# Certain sparc32 machines seem to have trouble building correctly with
	# -mcpu enabled.  While this is not a gnupg problem, it is a temporary
	# fix until the gcc problem can be tracked down.
	if [ "${ARCH}" == "sparc" ] && [ "${PROFILE_ARCH}" == "sparc" ]; then
		filter-flags -mcpu=supersparc -mcpu=v8 -mcpu=v7
	fi

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
		append-ldflags -static
	fi

	# Still needed?
	# Bug #6387, --enable-m-guard causes bus error on sparcs
	if ! use sparc; then
		myconf="${myconf} --enable-m-guard"
	fi

	use ppc-macos || append-ldflags -Wl,-z,now

	econf ${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} libexecdir="/usr/lib/gnupg" install || die

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc AUTHORS BUGS ChangeLog NEWS PROJECTS README THANKS \
		TODO VERSION doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

	use idea && dodoc ${S}/cipher/idea.c

	docinto sgml
	dodoc doc/*.sgml

	dohtml doc/faq.html

	chmod u+s "${D}/usr/bin/gpg"
}

pkg_postinst() {
	einfo "gpg is installed suid root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your"
	einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	echo
	if use idea; then
		einfo "Please read http://www.gnupg.org/why-not-idea.html for more"
		einfo "information on IDEA support."
		einfo
		einfo "If you are in a country where the IDEA algorithm is patented,"
		einfo "you are permitted to use it at no cost for 'non revenue"
		einfo "generating data transfer between private individuals'."
		einfo
		einfo "Countries where the patent applies are listed here"
		einfo "http://www.mediacrypt.com/_contents/10_idea/101030_ea_pi.asp"
	fi
	einfo
	einfo "See http://www.gentoo.org/doc/en/gnupg-user.xml for documentation on gnupg"
	einfo
}
