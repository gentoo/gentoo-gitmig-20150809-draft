# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.2.5.ebuild,v 1.1 2004/07/31 17:00:22 taviso Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gnupg/${P}.tar.bz2
	idea? ( ftp://ftp.gnupg.dk/pub/contrib-dk/idea.c.gz )"

LICENSE="GPL-2 | IDEA GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X ldap nls static idea"

RDEPEND="!static? ( ldap? ( net-nds/openldap )
		app-arch/bzip2
		sys-libs/zlib )
	X? ( || ( media-gfx/xloadimage media-gfx/xli ) )
	nls? ( sys-devel/gettext )
	dev-lang/perl
	virtual/libc"
# XXX: libpcap earlier than 1.10-r3 did not provide libcap.a
#	DEPEND="caps? ( static? ( >=sys-libs/libcap-1.10-r3 )
#				!static? ( sys-libs/libcap ) )
DEPEND="ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	!static? ( sys-libs/zlib )
	app-arch/bzip2
	dev-lang/perl
	virtual/libc"

src_unpack() {
	unpack ${A}

	if use hppa
	then
		cd ${S}
		epatch ${FILESDIR}/gnupg-1.2.4-hppa_unaligned_constant.patch
	fi

	# Please read http://www.gnupg.org/why-not-idea.html
	if use idea; then
		mv ${WORKDIR}/idea.c ${S}/cipher/idea.c || ewarn "failed to insert IDEA module"
	fi

	use ppc64 && epatch ${FILESDIR}/gnupg-1.2.4.ppc64.patch
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
	else
		myconf="${myconf} --without-included-zlib"
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

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS PROJECTS README THANKS \
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
