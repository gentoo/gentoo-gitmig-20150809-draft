# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.9.10.ebuild,v 1.8 2004/12/07 12:54:06 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gnupg/${P}.tar.gz"

LICENSE="GPL-2 idea? ( IDEA )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
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
	>=dev-libs/libksba-0.9.7
	smartcard? ( dev-libs/opensc )
	virtual/libc
	dev-lang/perl
	dev-libs/pth
	virtual/mta"
DEPEND="caps? ( sys-libs/libcap )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.7
	>=dev-libs/libassuan-0.6.6
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

	append-ldflags -Wl,-z,now

	econf \
		--libexecdir=/usr/lib \
		`use_enable smartcard scdaemon` \
		`use_enable nls` \
		`use_enable ldap` \
		`use_with caps capabilities` \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR=${D} libexecdir="/usr/lib/gnupg" install || die

	dosym gpg2 /usr/bin/gpg

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc ChangeLog INSTALL NEWS README THANKS TODO VERSION

	if ! use caps ; then
		fperms u+s /usr/bin/gpg2
		fperms u+s /usr/bin/gpg-agent
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
