# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.9.8.ebuild,v 1.8 2004/07/14 17:14:25 kugelfang Exp $

inherit eutils

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gnupg/${P}.tar.gz"

LICENSE="GPL-2 | GPL-2 IDEA"
SLOT="0"
KEYWORDS="~x86 ~mips ~alpha ~amd64"
IUSE="X caps ldap nls smartcard static"

RDEPEND="
	!static? (
		ldap? ( net-nds/openldap )
		caps? ( sys-libs/libcap )
		sys-libs/zlib
	)
	X? ( || ( media-gfx/xloadimage media-gfx/xli ) )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.42
	>=dev-libs/libksba-0.4.7
	smartcard? ( dev-libs/opensc )
	virtual/libc
	dev-lang/perl
	dev-libs/pth
	virtual/mta"
DEPEND="caps? ( sys-libs/libcap )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.6
	>=dev-libs/libassuan-0.6.5
	smartcard? ( dev-libs/opensc )
	sys-libs/zlib
	virtual/libc
	dev-lang/perl
	dev-libs/pth"

src_compile() {
	local myconf=""

	if use X; then
		local viewer
		if has_version 'media-gfx/xloadimage'; then
			viewer=/usr/bin/xloadimage
		else
			viewer=/usr/bin/xli
		fi
		myconf="${myconf} --with-photo-viewer=${viewer}"
	else
		myconf="${myconf} --disable-photo-viewers"
	fi

	econf \
		--libexecdir=/usr/lib \
		`use_enable smartcard scdaemon` \
		`use_enable nls` \
		`use_enable ldap` \
		`use_with caps capabilities` \
		|| die
	emake || die
}

src_install() {
	einstall libexecdir="${D}/usr/lib/gnupg"

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO VERSION \
		doc/{FAQ,HACKING,DETAILS,ChangeLog,OpenPGP,faq.raw}

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
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
	ewarn "	THIS IS _ALPHA_ CODE, IT MAY NOT WORK CORRECTLY OR AT ALL. THERE"
	ewarn "	MAY BE UNDISCOVERED SECURITY OR DATA-LOSS ISSUES, DO NOT USE "
	ewarn "	IN A PRODUCTION ENVIRONMENT."
	ewarn ""
	ewarn "	This ebuild is provided for those who wish to experiment with this"
	ewarn "	new branch of gnupg and beta-testers, not for general purpose use"
	ewarn "	by non-developers"
	ewarn ""
	ewarn "	Please see #37109"
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
}
